<users>
{
doc('DataFileName")/users/*
}
</users>

<users>
{
for $e in doc('AuditTrail.xml')/audit_trail/event
where $e/type = "submitForBatch" and not ($e[processed])
return doc($e/metadata/file_name/text())/users/*
}
</users>

let $e:=<event><time>ttt</time><type>initiateXBatchJob</type><queue_id>qqq</queue_id></event>
return insert node $e as first into /audit_trail
							
for $x in doc("books.xml")/bookstore/book
return	if ($x/@category="CHILDREN")
then <child>{data($x/title)}</child>
else <adult>{data($x/title)}</adult>

for $prod at $p in (1 to 10)
return $p

let $cd := current-date()
let $fd := $cd - xs:dayTimeDuration("P28D")
return
<users>
	{
	for $m in doc('/Members.xml')/members/member
	return
		<user>
		{
		for $u in doc('/xPressionHelper/FromHIP')/users/user
		where $u/external_id = $m/badge_number
		return
			<d>
			{
			for $prod at $p in (1 to 10)
			let $d := $fd + xs:dayTimeDuration(concat("P", $p, "D"))
			return
				<dd>{$d}</dd>
			}
			</d>
		}
		</user>
	}
</users>

************************************************************************************************************************
let $current_day := xs:date("2015-02-10")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
return
<users>
{
for $m in doc('/Members.xml')/members/member
return
		<user>
			<badge_number>{$m/badge_number/text()}</badge_number>
			<index_history>
				<items>
	{
	for $day_offset in (1 to 28)
	let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
	return
					<item>
						<day>{$day_offset}</day>
						<date>{$current_date}</date>
						<value>
		{						
		let $current_date_extract := xs:date(doc('/xPressionHelper/FromHIP/')/users/user[./external_id = $m/badge_number and xs:date(./index_history/last_value_date/text()) = xs:date($current_date)]/index_history/last_value_date/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := doc('/xPressionHelper/FromHIP/')/users/user[./external_id = $m/badge_number and xs:date(./index_history/last_value_date/text()) = xs:date($current_date)]/index_history/values/value[7]/text()
		return 
		if ($current_date_day=$current_date_extract)
		then $current_value
		else 0
		}
						</value>
					</item>
	}
				</items>
			</index_history>
		</user>
}
</users>

*************************************************************************************************************************
let $current_day := xs:date("2015-02-10")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
let $source := doc('/xPressionHelper/FromHIP/')
return
<users>
{
for $m in doc('/Members.xml')/members/member
let $u := $source/users/user[./external_id = $m/badge_number][1]
return
		<user>
			<badge_number>{$m/badge_number/text()}</badge_number>
			<username>{$u/username/text()}</username>
			<email>{$u/email/text()}</email>
			<gender>{$u/gender/text()}</gender>
			<index_history>
				<update_date>{$current_day}</update_date>
				<first_date>{$first_day}</first_date>
				<items>
	{
	for $day_offset in (1 to 28)
	let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
	return
					<item>
						<day_offset>{$day_offset}</day_offset>
						<date>{$current_date}</date>
						<value>
		{						
		let $current_date_extract := xs:date($source/users/user[
				./external_id = $m/badge_number
				and
				xs:date(./index_history/last_value_date/text()) = xs:date($current_date)
			]/index_history/last_value_date/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source/users/user[
				./external_id = $m/badge_number
				and
				xs:date(./index_history/last_value_date/text()) = xs:date($current_date)
			]/index_history/values/value[7]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then $current_value
			else 0
		}
						</value>
					</item>
	}
				</items>
			</index_history>
		</user>
}
</users>

*************************************************************************************************************************
let $current_day := xs:date("2015-02-15")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
let $source := doc('/xPressionHelper/FromDailyUpdates/')
let $award_threshold := 300
return
<MonthlyReports>
{
for $m in doc('/Members.xml')/members/member
return
	<MonthlyReport>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
		<update_date>{$current_day}</update_date>
		<first_date>{$first_day}</first_date>
		<award_threshold>{$award_threshold}</award_threshold>
		<days_above_threshold>{
count(distinct-values($source/daily_data/daily_member_data[
./member_id = $m/badge_number
and
xs:date(./date_stamp) > $first_day
and
xs:date(./date_stamp) < $current_day
and
./daily_index_value > $award_threshold
]/date_stamp))
		}</days_above_threshold>
		<index_history_items>
	{
	for $day_offset in (1 to 28)
	let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
	return
			<index_history_item>
				<day_offset>{$day_offset}</day_offset>
				<date>{$current_date}</date>
				<value>
		{						
		let $current_date_extract := xs:date($source/daily_data/daily_member_data[
				./member_id = $m/badge_number
				and
				xs:date(./date_stamp/text()) = xs:date($current_date)
			][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source/daily_data/daily_member_data[
				./member_id = $m/badge_number
				and
				xs:date(./date_stamp/text()) = xs:date($current_date)
			][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then $current_value
			else 0
		}
				</value>
			</index_history_item>
	}
		</index_history_items>
	</MonthlyReport>
}
</MonthlyReports>

**************************************************************************************************************
let $current_day := xs:date("2015-02-15")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
let $source := doc('/xPressionHelper/FromDailyUpdates/')
let $award_threshold := 300
let $award_days_above_threshold_required := 1
return
<MonthlyReports>
{
for $m in doc('/Members.xml')/members/member
let $days_above_threshold := count(distinct-values($source/daily_data/daily_member_data[./member_id = $m/badge_number and xs:date(./date_stamp) > $first_day and xs:date(./date_stamp) < $current_day and ./daily_index_value > $award_threshold]/date_stamp))
return
	<MonthlyReport>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
		<update_date>{$current_day}</update_date>
		<first_date>{$first_day}</first_date>
		<award_threshold>{$award_threshold}</award_threshold>
		<days_above_threshold>{$days_above_threshold}</days_above_threshold>
		<award>{$days_above_threshold > $ award_days_above_threshold_required}</award>
		<index_history_items>
	{
	for $day_offset in (1 to 28)
	let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
	return
			<index_history_item>
				<day_offset>{$day_offset}</day_offset>
				<date>{$current_date}</date>
				<value>
		{						
		let $current_date_extract := xs:date($source/daily_data/daily_member_data[
				./member_id = $m/badge_number
				and
				xs:date(./date_stamp/text()) = xs:date($current_date)
			][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source/daily_data/daily_member_data[
				./member_id = $m/badge_number
				and
				xs:date(./date_stamp/text()) = xs:date($current_date)
			][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then $current_value
			else 0
		}
				</value>
			</index_history_item>
	}
		</index_history_items>
	</MonthlyReport>
}
</MonthlyReports>

**************************************************************************************************************
fn:string-join(for $x in $doc/LineChart/Labels/Label return concat("'", string($x),"'"),",")

**************************************************************************************************************
let $current_day := xs:date("2015-02-15")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
let $source := doc('/xPressionHelper/FromDailyUpdates/')
let $award_threshold := 300
let $award_days_above_threshold_required := 1
return
<MonthlyReports>
{
for $m in doc('/Members.xml')/members/member
let $days_above_threshold := count(distinct-values($source/daily_data/daily_member_data[./member_id = $m/badge_number and xs:date(./date_stamp) > $first_day and xs:date(./date_stamp) < $current_day and ./daily_index_value > $award_threshold]/date_stamp))
return
	<MonthlyReport>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
		<update_date>{$current_day}</update_date>
		<first_date>{$first_day}</first_date>
		<award_threshold>{$award_threshold}</award_threshold>
		<days_above_threshold>{$days_above_threshold}</days_above_threshold>
		<award>{$days_above_threshold > $ award_days_above_threshold_required}</award>
		<index_history>
	{
	fn:string-join(
		for $day_offset in (1 to 28)
		let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
		let $current_date_extract := xs:date($source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then concat($current_date_day, "=", $current_value)
			else concat($current_date_day, "=0")
		,
		'; ')
	 }
		</index_history>
	</MonthlyReport>
}
</MonthlyReports>

****
let $current_day := xs:date("2015-02-15")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
let $source := doc('/xPressionHelper/FromDailyUpdates/')
let $award_threshold := 300
let $award_days_above_threshold_required := 1
return
<MonthlyReports>
{
for $m in doc('/Members.xml')/members/member
let $days_above_threshold := count(distinct-values($source/daily_data/daily_member_data[./member_id = $m/badge_number and xs:date(./date_stamp) > $first_day and xs:date(./date_stamp) < $current_day and ./daily_index_value > $award_threshold]/date_stamp))
return
	<MonthlyReport>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
		<update_date>{$current_day}</update_date>
		<first_date>{$first_day}</first_date>
		<award_threshold>{$award_threshold}</award_threshold>
		<days_above_threshold>{$days_above_threshold}</days_above_threshold>
		<award>{$days_above_threshold > $ award_days_above_threshold_required}</award>
		<index_history_nvp>
	{
	fn:string-join(
		for $day_offset in (1 to 28)
		let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
		let $current_date_extract := xs:date($source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then concat($current_date_day, '=', $current_value)
			else concat($current_date_day, '=0')
		,
		';'
	)
	}
		</index_history_nvp>
		<index_history_csv>
	{
	concat(
		concat(
			'Categories',
			';',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return $current_date_day
				,
				';'
			),
			'#'
		),
		concat(
			'Serie 1',
			';',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then $current_value
					else "0"
				,
				';'
			)
		)
	)
	}
		</index_history_csv>
		<index_history_xml>
	{
	concat(
		concat(
			'<categories><title>Date</title><values>',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return concat('<value>', $current_date_day,'</value>')
				,
				''
			),
			'</values></categories>'
		),
		concat(
			'<serie><title>Index</title><values>',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then concat('<value>', $current_value, '</value>')
					else "<value>0</value>"
				,
				''
			),
			'</values><serie>'
		)
	)
	}
		</index_history_xml>
	</MonthlyReport>
}
</MonthlyReports>

****
let $current_day := xs:date("2015-02-15")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
let $source := doc('/xPressionHelper/FromDailyUpdates/')
let $award_threshold := 300
let $award_days_above_threshold_required := 1
return
<MonthlyReports>
{
for $m in doc('/Members.xml')/members/member
let $days_above_threshold := count(distinct-values($source/daily_data/daily_member_data[./member_id = $m/badge_number and xs:date(./date_stamp) > $first_day and xs:date(./date_stamp) < $current_day and ./daily_index_value > $award_threshold]/date_stamp))
return
	<MonthlyReport>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
		<update_date>{$current_day}</update_date>
		<first_date>{$first_day}</first_date>
		<award_threshold>{$award_threshold}</award_threshold>
		<days_above_threshold>{$days_above_threshold}</days_above_threshold>
		<award>{$days_above_threshold > $ award_days_above_threshold_required}</award>
		<index_history_nvp>
	{
	fn:string-join(
		for $day_offset in (1 to 28)
		let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
		let $current_date_extract := xs:date($source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then concat($current_date_day, '=', $current_value)
			else concat($current_date_day, '=0')
		,
		';'
	)
	}
		</index_history_nvp>
		<index_history_csv>
	{
	concat(
		concat(
			'Categories',
			';',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return $current_date_day
				,
				';'
			),
			'#'
		),
		concat(
			'Serie 1',
			';',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then $current_value
					else "0"
				,
				';'
			)
		)
	)
	}
		</index_history_csv>
		<index_history_xml>
	{
	concat(
		'<line_chart>',
		concat(
			'<categories><title>Date</title><values>',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return concat('<value>', $current_date_day,'</value>')
				,
				''
			),
			'</values></categories>'
		),
		'<series>',
		concat(
			'<serie><title>Index</title><values>',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then concat('<value>', $current_value, '</value>')
					else "<value>0</value>"
				,
				''
			),
			'</values></serie>'
		),
		'</series>',
		'</line_chart>'
	)
	}
		</index_history_xml>
	</MonthlyReport>
}
</MonthlyReports>

***********************************************************************************************************
let $current_day := xs:date("2015-02-15")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
let $source := doc('/xPressionHelper/FromDailyUpdates/')
let $award_threshold := 300
let $award_days_above_threshold_required := 1
return
<MonthlyReports>
{
for $m in doc('/Members.xml')/members/member
let $days_above_threshold := count(distinct-values($source/daily_data/daily_member_data[./member_id = $m/badge_number and xs:date(./date_stamp) > $first_day and xs:date(./date_stamp) < $current_day and ./daily_index_value > $award_threshold]/date_stamp))
return
	<MonthlyReport>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
		<update_date>{$current_day}</update_date>
		<first_date>{$first_day}</first_date>
		<award_threshold>{$award_threshold}</award_threshold>
		<days_above_threshold>{$days_above_threshold}</days_above_threshold>
		<award>{$days_above_threshold > $ award_days_above_threshold_required}</award>
		<index_history_nvp>
	{
	fn:string-join(
		for $day_offset in (1 to 28)
		let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
		let $current_date_extract := xs:date($source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then concat($current_date_day, '=', $current_value)
			else concat($current_date_day, '=0')
		,
		';'
	)
	}
		</index_history_nvp>
		<index_history_csv>
	{
	concat(
		concat(
			'Categories',
			';',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return $current_date_day
				,
				';'
			),
			'#'
		),
		concat(
			'Serie 1',
			';',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then $current_value
					else "0"
				,
				';'
			)
		)
	)
	}
		</index_history_csv>
		<index_history_xml>
	{
	concat(
		'<chart_data>',
		concat(
			'<categories><title>Date</title><values>',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return concat('<value>', $current_date_day,'</value>')
				,
				''
			),
			'</values></categories>'
		),
		'<series>',
		concat(
			'<serie><title>Index</title><values>',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then concat('<value>', $current_value, '</value>')
					else "<value>0</value>"
				,
				''
			),
			'</values></serie>'
		),
		'</series>',
		'</chart_data>'
	)
	}
		</index_history_xml>
	</MonthlyReport>
}
</MonthlyReports>

*******************************************
let $current_day := xs:date("2015-02-15")
let $first_day := $current_day - xs:dayTimeDuration("P28D")
let $source := doc('/xPressionHelper/FromDailyUpdates/')
let $award_threshold := 300
let $award_days_above_threshold_required := 1
return
<MonthlyReports>
{
for $m in doc('/Members.xml')/members/member
let $days_above_threshold := count(distinct-values($source/daily_data/daily_member_data[./member_id = $m/badge_number and xs:date(./date_stamp) > $first_day and xs:date(./date_stamp) < $current_day and ./daily_index_value > $award_threshold]/date_stamp))
return
	<MonthlyReport>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
		<update_date>{$current_day}</update_date>
		<first_date>{$first_day}</first_date>
		<award_threshold>{$award_threshold}</award_threshold>
		<days_above_threshold>{$days_above_threshold}</days_above_threshold>
		<award>{$days_above_threshold > $ award_days_above_threshold_required}</award>
		<index_history_nvp>
	{
	fn:string-join(
		for $day_offset in (1 to 28)
		let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
		let $current_date_extract := xs:date($source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then concat($current_date_day, '=', $current_value)
			else concat($current_date_day, '=0')
		,
		';'
	)
	}
		</index_history_nvp>
		<index_history_csv>
	{
	concat(
		concat(
			'Categories',
			';',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return $current_date_day
				,
				';'
			),
			'#'
		),
		concat(
			'Serie 1',
			';',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then $current_value
					else "0"
				,
				';'
			)
		)
	)
	}
		</index_history_csv>
		<index_history_xml>
	{
	concat(
		'<chart_data>',
		concat(
			'<categories><title>Date</title><values>',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return concat('<value>', $current_date_day,'</value>')
				,
				''
			),
			'</values></categories>'
		),
		'<series>',
		concat(
			'<serie><title>Index</title><values>',
			fn:string-join(
				for $day_offset in (1 to 28)
				let $current_date := $first_day + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then concat('<value>', $current_value, '</value>')
					else "<value>0</value>"
				,
				''
			),
			'</values></serie>'
		),
		'</series>',
		'</chart_data>'
	)
	}
		</index_history_xml>
	</MonthlyReport>
}
</MonthlyReports>

******
let $source1 := doc('/xPressionHelper/FromWeeklyUpdates/')
let $source2 := doc('/xPressionHelper/FromDailyUpdates/')
return
<WeeklyReports>
{
for $m in doc('/Members.xml')/members/member
for $r in $source1/weekly_data/weekly_member_data[./member_id = $m/badge_number]
return
	<WeeklyReport>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
	{$r/week_start_date}
	{$r/recomendations}
		<index_history_nvp>
	{
	fn:string-join(
		for $day_offset in (1 to 7)
		let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
		let $current_date_extract := xs:date($source2/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source2/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then concat($current_date_day, '=', $current_value)
			else concat($current_date_day, '=0')
		,
		';'
	)
	}
		</index_history_nvp>
		<index_history_csv>
	{
	concat(
		concat(
			'Categories',
			';',
			fn:string-join(
				for $day_offset in (1 to 7)
				let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return $current_date_day
				,
				';'
			),
			'#'
		),
		concat(
			'Serie 1',
			';',
			fn:string-join(
				for $day_offset in (1 to 7)
				let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source2/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source2/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then $current_value
					else "0"
				,
				';'
			)
		)
	)
	}
		</index_history_csv>
		<index_history_xml>
	{
	concat(
		'<chart_data>',
		concat(
			'<categories><title>Date</title><values>',
			fn:string-join(
				for $day_offset in (1 to 7)
				let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return concat('<value>', $current_date_day,'</value>')
				,
				''
			),
			'</values></categories>'
		),
		'<series>',
		concat(
			'<serie><title>Index</title><values>',
			fn:string-join(
				for $day_offset in (1 to 7)
				let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source2/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source2/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then concat('<value>', $current_value, '</value>')
					else "<value>0</value>"
				,
				''
			),
			'</values></serie>'
		),
		'</series>',
		'</chart_data>'
	)
	}
		</index_history_xml>
	</WeeklyReport>
}
</WeeklyReports>

***********
let $start_date := xs:date("2015-02-25")
return
<chart>
{
for $day_offset in (1 to 7)
let $current_date := xs:date($start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
return
	<item>
		<count_events>{count(doc('/AuditTrail.xml')/audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date])}</count_events>
		<count_IBJ>{count(doc('/AuditTrail.xml')/audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date and ./type = "initiateXBatchJob"])}</count_IBJ>
		<count_RNU>{count(doc('/AuditTrail.xml')/audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date and ./type = "registerNewUser"])}</count_RNU>
	</item>
}
</chart>

****
let $input_date := xs:date("2015-03-03"), 
$start_date := $input_date - xs:dayTimeDuration("P28D"), 
$audit_trail := doc('/AuditTrail.xml')/audit_trail,
$members := doc('/Members.xml')/members
return
<hr_stats>
<date>{$input_date}</date>
<member_count>{count($members/member)}</member_count>
<enrollment_requests_count>{count($audit_trail/event[./type = "registerNewUser"])}</enrollment_requests_count>
<report_runs_count>{count($audit_trail/event[./type = "initiateXBatchJob"])}</report_runs_count>
<last_four_weeks_history>
{
for $day_offset in (1 to 28)
let $current_date := xs:date($start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
return
<item>
<date>{$current_date}</date>
<day_runs>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date and ./type = "initiateXBatchJob"])}</day_runs>
<day_enrollment_requests>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date and ./type = "registerNewUser"])}</day_enrollment_requests>
<total_enrollment_requests>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) <= $current_date and ./type = "registerNewUser"])}</total_enrollment_requests>
</item>
}
</last_four_weeks_history>
</hr_stats>

****
let $m := /members/member[./last_name = 'Doe'][1]
return delete node $m

****
let $m := /daily_data/daily_member_data[1]
return
if ($m/daily_index_value > 350)
then insert node <daily_index_level_label>outstanding</daily_index_level_label> after $m/daily_index_value
else insert node <daily_index_level_label>caca</daily_index_level_label> after $m/daily_index_value

****
let $m := /daily_data/daily_member_data[1]
return
if ($m/daily_index_value > 350)
   then
      insert node (
	<daily_index_level>1</daily_index_level>,
	<daily_index_level_label>outstanding</daily_index_level_label>,
	<daily_index_color>00AA00</daily_index_color>
      ) after $m/daily_index_value
   else
      if ($m/daily_index_value > 200)
         then
            insert node (
               <daily_index_level>2</daily_index_level>,
               <daily_index_level_label>acceptable</daily_index_level_label>,
               <daily_index_color>AAAA00</daily_index_color>
            ) after $m/daily_index_value
         else
            insert node (
               <daily_index_level>3</daily_index_level>,
               <daily_index_level_label>just</daily_index_level_label>,
               <daily_index_color>0000AA</daily_index_color>
            ) after $m/daily_index_value
            
****
for $m in /daily_data/daily_member_data
return
if ($m/daily_index_value > 350)
   then
      insert node (
	<daily_index_level>1</daily_index_level>,
	<daily_index_level_label>outstanding</daily_index_level_label>,
	<daily_index_color>00AA00</daily_index_color>
      ) after $m/daily_index_value
   else
      if ($m/daily_index_value > 200)
         then
            insert node (
               <daily_index_level>2</daily_index_level>,
               <daily_index_level_label>acceptable</daily_index_level_label>,
               <daily_index_color>AAAA00</daily_index_color>
            ) after $m/daily_index_value
         else
            insert node (
               <daily_index_level>3</daily_index_level>,
               <daily_index_level_label>just</daily_index_level_label>,
               <daily_index_color>0000AA</daily_index_color>
            ) after $m/daily_index_value


****
for $m in doc('/xPressionHelper/FromDailyUpdates/')//daily_data/daily_member_data
return
if ($m/daily_index_value > 350)
  then
  insert node (
    <daily_index_level>1</daily_index_level>,
    <daily_index_level_label>outstanding</daily_index_level_label>,
    <daily_index_color>00AA00</daily_index_color>
    ) after $m/daily_index_value
  else
  if ($m/daily_index_value > 200)
    then
    insert node (
      <daily_index_level>2</daily_index_level>,
      <daily_index_level_label>acceptable</daily_index_level_label>,
      <daily_index_color>AAAA00</daily_index_color>
      ) after $m/daily_index_value
    else
    insert node (
      <daily_index_level>3</daily_index_level>,
      <daily_index_level_label>just</daily_index_level_label>,
      <daily_index_color>0000AA</daily_index_color>
      ) after $m/daily_index_value

****
for $m in doc('/xPressionHelper/FromWeeklyUpdates/')//weekly_data/weekly_member_data
return
  insert node (
    <weekly_index_value>350</weekly_index_value>,
    <weekly_index_level>1</weekly_index_level>,
    <weekly_index_level_label>good</weekly_index_level_label>,
    <weekly_index_color>00AA00</weekly_index_color>
  ) before $m/week_start_date
  
  
****
let $threshold := 300
let $needed_days := 5
let $a := for $m in doc('Members.xml')/members/member
where count(doc('/xPressionHelper/FromDailyUpdates/')/daily_data/daily_member_data[./member_id = $m/badge_number and ./daily_index_value > $threshold]) >= $needed_days
return $m
return count($a)

let $threshold := 100
let $needed_days := 5
let $end_date := xs:date("2015-03-06")
let $start_date := $end_date - xs:dayTimeDuration("P28D")
let $possibly_awarded_members := for $m in doc('Members.xml')/members/member
where count
  (
    doc('/xPressionHelper/FromDailyUpdates/')/daily_data/daily_member_data[
      ./member_id = $m/badge_number
      and
      ./daily_index_value > $threshold
    ]
  ) >= $needed_days
return $m
return 
<simulations>
  <simulation>
    <threshold>{$threshold}</threshold>
    <needed_days>{$needed_days}</needed_days>
    <end_date>{$end_date}</end_date>
    <start_date>{$start_date}</start_date>
    <possibly_awarded_members_count>{count($possibly_awarded_members)}</possibly_awarded_members_count>
    <needed_days_impact_chart>
{
for $nd in (1 to 15) (:3, 5, 10, 15):)
let $possibly_awarded_members2 := for $m in doc('Members.xml')/members/member
where count
  (
    doc('/xPressionHelper/FromDailyUpdates/')/daily_data/daily_member_data[
      ./member_id = $m/badge_number
      and
      ./daily_index_value > $threshold
    ]
  ) >= $nd
return $m
return <item><needed_days>{$nd}</needed_days><pam>{count($possibly_awarded_members2)}</pam></item>
}
    </needed_days_impact_chart>
    <threshold_impact_chart>
{
for $s in (1 to 14)
let $t := $s*50
let $possibly_awarded_members3 := for $m in doc('Members.xml')/members/member
where count
  (
    doc('/xPressionHelper/FromDailyUpdates/')/daily_data/daily_member_data[
      ./member_id = $m/badge_number
      and
      ./daily_index_value > $t
    ]
  ) >= $needed_days
return $m
return <item><threshold>{$t}</threshold><pam>{count($possibly_awarded_members3)}</pam></item>
}
    </threshold_impact_chart>
  </simulation>
</simulations>

****
let $input_date := xs:date("2015-03-03")
let $start_date := $input_date - xs:dayTimeDuration("P28D")
let $members := doc('/Members.xml')/members/member
let $daily_member_data := doc('/xPressionHelper/FromDailyUpdates')/daily_data/daily_member_data
return
<teams>
{
for $team in distinct-values($members/team)
return
<team>
<team_name>{$team}</team_name>
<last_four_weeks_history>
{
for $day_offset in (1 to 28)
let $current_date := xs:date($start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
let $daily_index_values := for $m in $members where $m/team = $team return $daily_member_data/daily_index_value[xs:date(../date_stamp) = $current_date and ../member_id = $m/badge_number]
let $c := count($daily_index_values)
let $a := avg($daily_index_values)
return
<item>
<date>{$current_date}</date>
<sample_count>{$c}</sample_count>
<avg>{if ($c>0) then $a else 0}</avg>
</item>
}
</last_four_weeks_history>
</team>
}
</teams>

****
let $input_date := xs:date("2015-03-03")
let $start_date := $input_date - xs:dayTimeDuration("P28D")
let $members := doc('/Members.xml')/members/member
let $daily_member_data := doc('/xPressionHelper/FromDailyUpdates')/daily_data/daily_member_data
let $audit_trail := doc('/AuditTrail.xml')/audit_trail
let $program_config := doc('ProgramConfiguration.xml')/program_configuration
return
<stats>
<date>{$input_date}</date>
{$program_config/available_devices_count}
<member_count>{count($members)}</member_count>
<enrollment_requests_count>{count($audit_trail/event[./type = "registerNewUser"])}</enrollment_requests_count>
<last_four_weeks_history>
<items>
{
for $day_offset in (1 to 28)
let $current_date := xs:date($start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
return
<item>
<date>{$current_date}</date>
<day_enrollment_requests>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date and ./type = "registerNewUser"])}</day_enrollment_requests>
<total_enrollment_requests>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) <= $current_date and ./type = "registerNewUser"])}</total_enrollment_requests>
<day_runs>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date and ./type = "initiateXBatchJob"])}</day_runs>
<sample_count>{count($daily_member_data/daily_index_value[xs:date(../date_stamp) = $current_date])}</sample_count>
<teams>
{
for $team in distinct-values($members/team)
let $daily_index_values := for $m in $members where $m/team = $team return $daily_member_data/daily_index_value[xs:date(../date_stamp) = $current_date and ../member_id = $m/badge_number]
let $c := count($daily_index_values)
let $a := avg($daily_index_values)
return
<team>
<team_name>{$team}</team_name>
<team_sample_count>{$c}</team_sample_count>
<team_avg>{if ($c>0) then $a else 0}</team_avg>
</team>
}
</teams>
</item>
}
</items>
</last_four_weeks_history>
</stats>

****
let $input_date := xs:date("2015-03-08")
let $start_date := $input_date - xs:dayTimeDuration("P28D")
let $members := doc('/Members.xml')/members/member
let $daily_member_data := doc('/xPressionHelper/FromDailyUpdates')/daily_data/daily_member_data
let $audit_trail := doc('/AuditTrail.xml')/audit_trail
let $program_config := doc('ProgramConfiguration.xml')/program_configuration
return
<stats>
<date>{$input_date}</date>
{$program_config/available_devices_count}
<member_count>{count($members)}</member_count>
<enrollment_requests_count>{count($audit_trail/event[./type = "registerNewUser"])}</enrollment_requests_count>
<last_four_weeks_history>
<items>
{
for $day_offset in (1 to 28)
let $current_date := xs:date($start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
let $daily_index_values := $daily_member_data/daily_index_value[xs:date(../date_stamp) = $current_date]
let $c0 := count($daily_index_values)
let $a0 := avg($daily_index_values)
return
<item>
<date>{$current_date}</date>
<day_enrollment_requests>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date and ./type = "registerNewUser"])}</day_enrollment_requests>
<total_enrollment_requests>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) <= $current_date and ./type = "registerNewUser"])}</total_enrollment_requests>
<day_runs>{count($audit_trail/event[xs:date(substring(./time/text(), 1, 10)) = $current_date and ./type = "initiateXBatchJob"])}</day_runs>
<sample_count>{count($daily_member_data/daily_index_value[xs:date(../date_stamp) = $current_date])}</sample_count>
<member_count>{count($members[xs:date(enrollment_date) <= $current_date])}</member_count>
<avg>{if ($c0>0) then $a0 else 0}</avg>
<teams>
{
for $team in distinct-values($members/team)
let $team_daily_index_values := for $m in $members where $m/team = $team return $daily_member_data/daily_index_value[xs:date(../date_stamp) = $current_date and ../member_id = $m/badge_number]
let $c1 := count($team_daily_index_values)
let $a1 := avg($team_daily_index_values)
return
<team>
<team_name>{$team}</team_name>
<team_sample_count>{$c1}</team_sample_count>
<team_avg>{if ($c1>0) then $a1 else 0}</team_avg>
</team>
}
</teams>
</item>
}
</items>
</last_four_weeks_history>
</stats>

****
let $ab := 10000
let $at := 350
let $adan := 10
let $pc := doc('ProgramConfiguration.xml')/program_configuration
return
(
  replace value of node $pc/available_devices_count with $adc,
  replace value of node $pc/awards_budget with $ab,
  replace value of node $pc/awards_threshold with $at,
  replace value of node $pc/awards_days_above_needed with $adan
)

****
let $adc:=110, $ab:=10000, $at:=350, $adan:=10, $pc:=doc('ProgramConfiguration.xml')/program_configuration return (replace value of node $pc/available_devices_count with $adc, replace value of node $pc/awards_budget with $ab, replace value of node $pc/awards_threshold with $at, replace value of node $pc/awards_days_above_needed with $adan)


****
for $m in doc('users.json.xml')/members/member
return insert node (
<!-- added using xQuery - Start -->,
<badge_number>{$m/member_id/text()}</badge_number>,
<first_name>{$m/display_name/text()}</first_name>,
<last_name></last_name>,
<vitex_id>{$m/username/text()}</vitex_id>,
<enrollment_date>2015-01-12</enrollment_date>,
<team>Sales</team>,
<!-- added using xQuery - End -->
)
before $m/username

****
for $m in doc('users.json.xml')/members/member
return concat(
"CREATE wp02_member OBJECT ",
"SET badge_number='", $m/badge_number, "', ",
"SET email='", $m/email, "', ",
"SET first_name='", $m/display_name, "', ",
"SET gender='", $m/gender, "', ",
"SET member_id='", $m/member_id, "', ",
"SET login='", $m/username, "'
GO"
)

for $m in doc('users.json.xml')/members/member
return concat(
"CREATE dm_user OBJECT ",
"SET user_name = '", $m/username, "', ",
"SET user_address = '", $m/email, "', ",
"SET description = 'Member', ",
"SET user_source = 'inline password', ",
"SET user_login_name = '", $m/username, "', ",
"SET user_password='", $m/password, "', ",
"SET user_state = 0
GO"
)

concat(
"ALTER GROUP wp02_member ADD ",
string-join(for $m in doc('users.json.xml')/members/member return $m/username, ", "),
""
)

****
let $source1 := doc('/xPressionHelper/FromWeeklyUpdates/')
let $source2 := doc('/xPressionHelper/FromDailyUpdates/')
let $award_threshold := doc('/ProgramConfiguration.xml')/program_configuration/awards_threshold/text()
return
<documents>
{
(:for $m in doc('/Members.xml')/members/member:)
for $m in /members/member
for $r in $source1/weekly_data/weekly_member_data[./member_id = $m/badge_number][last()]
return
	<document>
		<document_type>Weekly</document_type>
		<badge_number>{$m/badge_number/text()}</badge_number>
		<email>{$m/email/text()}</email>
		<first_name>{$m/first_name/text()}</first_name>
		<last_name>{$m/last_name/text()}</last_name>
		<gender>{$m/gender/text()}</gender>
	{$r/week_start_date}
	{$r/recomendations}
		<index_history_nvp>
	{
	fn:string-join(
		for $day_offset in (1 to 7)
		let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
		let $current_date_extract := xs:date($source2/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/date_stamp/text())
		let $current_date_day := xs:date($current_date)
		let $current_value := $source2/daily_data/daily_member_data[
			./member_id = $m/badge_number
			and
			xs:date(./date_stamp/text()) = xs:date($current_date)
		][1]/daily_index_value[1]/text()
		return 
			if ($current_date_day=$current_date_extract)
			then concat($current_date_day, '=', $current_value)
			else concat($current_date_day, '=0')
		,
		';'
	)
	}
		</index_history_nvp>
		<index_history_csv>
	{
	concat(
		concat(
			'Categories',
			';',
			fn:string-join(
				for $day_offset in (1 to 7)
				let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return $current_date_day
				,
				';'
			),
			'#'
		),
		concat(
			'Serie 1',
			';',
			fn:string-join(
				for $day_offset in (1 to 7)
				let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source2/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source2/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then $current_value
					else "0"
				,
				';'
			)
		)
	)
	}
		</index_history_csv>
		<index_history_xml>
	{
	concat(
		'<chart_data>',
		'<horizontal_marker>',
		'<value>', $award_threshold, '</value>',
		'<line_style></line_style>',
		'<line_color>FFFF00</line_color>',
		'<label>AT</label>',
		'</horizontal_marker>',
		concat(
			'<categories><title>Date</title><values>',
			fn:string-join(
				for $day_offset in (1 to 7)
				let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_day := xs:string($current_date)
				return concat('<value>', $current_date_day,'</value>')
				,
				''
			),
			'</values></categories>'
		),
		'<series>',
		concat(
			'<serie><title>Index</title><values>',
			fn:string-join(
				for $day_offset in (1 to 7)
				let $current_date := xs:date($r/week_start_date) + xs:dayTimeDuration(concat("P", $day_offset, "D"))
				let $current_date_extract := xs:date($source2/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/date_stamp/text())
				let $current_date_day := xs:date($current_date)
				let $current_value := $source2/daily_data/daily_member_data[
					./member_id = $m/badge_number
					and
					xs:date(./date_stamp/text()) = xs:date($current_date)
				][1]/daily_index_value[1]/text()
				return 
					if ($current_date_day=$current_date_extract)
					then concat('<value>', $current_value, '</value>')
					else "<value>0</value>"
				,
				''
			),
			'</values></serie>'
		),
		'</series>',
		'</chart_data>'
	)
	}
		</index_history_xml>
	</document>
}
</documents>

(: --------------------------------------------------------------------------------- :)
for $m in doc('users.json.xml')/members/member
return replace value of node $m/team with "Vitex"(: Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" useresolver="yes" url="" outputurl="" processortype="datadirect" tcpport="1992866318" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" host="" port="0" user="" password="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProperties name="DocumentURIResolver" value=""/>
			<advancedProperties name="CollectionURIResolver" value=""/>
			<advancedProperties name="ModuleURIResolver" value=""/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
:)