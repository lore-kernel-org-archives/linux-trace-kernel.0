Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB25208D7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067677; cv=none; b=lloH/zbJKvqwi7eacer2q48aKq1GhHUPeLqzYzS0lpzFaIjr/DiS15hNmMXqz4ZGOHGiJOW30BwzdbvZUmg/ERTvIFD9WvZrqdVluqR8hqWqGKw0ujufKHr07N8HnKbdkfkAArip7rv1EjoImw0zLCd7IxqPtgWU+prlOJOEx7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067677; c=relaxed/simple;
	bh=YxoQ3302VVK6RBd7JOLcd/pvBsu15GFY+3Lyjs0wQTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/BCZ0VXyFjji+jHlALn+4HyqD+IOvbgDReGd67dkKlKNt3Fxq30MDYoOTQ3P6LJTDaCEzLuOJxeQsndd6EeKKeQt7DUdX0gg1s+/1ysTPhC/v1eq97iKeqCfqhY8AK9nMuNCZFPbmXmXfLy/qdk8DyWvz0cGNEzjvF2Z9UQlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so15492735e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 02:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067673; x=1790672473;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lecd9aSSVKlAMcWInmOgPiHqYN3Sf+43fP8VaSX/kNU=;
        b=J/URCbbIeppOAZVhfnsywTluEEjUVl0pPi45fViniIB6bCUBiobvhovdj9Z1/OV3s4
         Ujw2Q8mvJUvaMKW86A+BX2Kctn9uuVPE/ucjobk7k19ieaKmfXOy6vJpKuMbgRrjI+Q6
         DujiswMnjuTL6XB+E4nsS0gvfbuw/zrRj6m1b3lfzn7zR9tIUhPjOkSNqpzJuo6Mo4yU
         LVzK1Saaz9wRRpvVeBlnhrDqQcXE9Kl4TfA3GD3mjVjpDvlWwTpbhFWZTRy4YcRR3R+q
         Txcqomc688+e0Us/ZduoXXj+2Nw/7FmUFGleqoP93McratuBkx9/DU8CeMgqc5//qpsx
         eeEg==
X-Forwarded-Encrypted: i=1; AKwUvBzsg0m4wJlZI22BSK2C3XVTByzGPlVpo6kWDiGMjkdTyzdbaQKphJb6lmWYHSPHJ1nguGwI0bhmOx1ORP0HbOC1468=@vger.kernel.org
X-Gm-Message-State: AFuF++m40H12buN7SCY4qWukFvL6al1AYAokFAOHK0hpfSayapFTh0bX
	NyjPxqPWI1UjVW1qD7B5pi9gWZeptwSbH6IWlOXzzO8dBXeWgvgJllfy
X-Gm-Gg: AYBFou1PSwrIyiKd/g+hafZg1ZUO/E/373lJkROVkPAI+todp98RZaMQKNWzPSusAh8
	oq6YZ4y+JsT7igfmBpo42rNYAPSw6iBpEnZ0N8FMEdX09iL96DlJBxYjChpLiPwMRlFspH9d98H
	KwsLccwhVpFqR1W9giDWqNhwXU0taY3OdSezlldNXku1DpOivnxS8geIVVmglDZy3LBibUx1qlt
	z2M1x3fGMfaVVwJCfBveeQluhXAa7SzopD9dpdqCGAW0C+anXrzEUW8UMHGlyKWiTc+MwDw105f
	RGsOC86h8yZsCCFRo0tx+xlxA/+K6RcfIDRAR6f9st2rbw6NZBljTTCeSEo/Ug6JMl2bvXL8kCK
	dblULBU5Rc9d4PEp9KEgsKPVd1qsuyrMiRJaFoCmp5TWukwDRGpl8LpQBnJjTO2Zcbr9pqYLH0W
	hDH7Is51io1w+84Sth7vCGS3gCISfsaASjMrhvYmLYA1jU/f2DU9lCf9fkX8wNAyMuxQqftLf5y
	1f/1Zdv0wtqfwme9QcnQwK9D+IjodPaXNDiw9GzENM4Q20=
X-Received: by 2002:a05:6000:491e:b0:487:11e1:cab2 with SMTP id ffacd0b85a97d-4871e36fa85mr19168813f8f.49.1790067672483;
        Tue, 22 Sep 2026 02:01:12 -0700 (PDT)
Received: from [192.168.88.241] (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488627744f5sm3701294f8f.7.2026.09.22.02.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:01:12 -0700 (PDT)
Message-ID: <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
Date: Tue, 22 Sep 2026 11:01:10 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
To: Johannes Berg <johannes@sipsolutions.net>,
 Ilya Maximets <i.maximets@ovn.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Adrian Moreno <amorenoz@redhat.com>, Antoine Tenart <atenart@kernel.org>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net>
 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
 <99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
 <4a0240a7b9ff87302620a95c73f4f265cd428618.camel@sipsolutions.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <4a0240a7b9ff87302620a95c73f4f265cd428618.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 1:20 AM, Johannes Berg wrote:
> On Tue, 2026-09-22 at 00:36 +0200, Johannes Berg wrote:
>>
>> Indeed. Something like this (untested right now, didn't manage to spin
>> up a test yet):
>>
>> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> index a31f7fb6882d..9b8edfcd2d1a 100755
>> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
>> @@ -234,7 +234,7 @@ ovs_drop_reason_count()
>>  	local reason=$1
>>  
>>  	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
>> -	local pattern="skb:kfree_skb:.*reason: $reason"
>> +	local pattern="skb:kfree_skb:.*reason: $reason$"
>>  
>>  	return `echo "$perf_output" | grep "$pattern" | wc -l`
>>  }
>> @@ -790,15 +790,6 @@ test_psample() {
>>  # - drop packets and verify the right drop reason is reported
>>  test_drop_reason() {
>>  	which perf >/dev/null 2>&1 || return $ksft_skip
>> -	which pahole >/dev/null 2>&1 || return $ksft_skip
>> -
>> -	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
>> -			      awk '/OPENVSWITCH/ { print $3; }' |
>> -			      tr -d ,)
>> -	if [ -z "$ovs_drop_subsys" ]; then
>> -		info "failed to get OVS drop subsys ID"
>> -		return $ksft_skip
>> -	fi
>>  
>>  	sbx_add "test_drop_reason" || return $?
>>  
>> @@ -842,7 +833,7 @@ test_drop_reason() {
>>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
>>  
>>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
>> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
>> +	ovs_drop_reason_count OVS_DROP_LAST_ACTION
>>  	if [[ "$?" -ne "2" ]]; then
>>  		info "Did not detect expected drops: $?"
>>  		return 1
>> @@ -859,7 +850,7 @@ test_drop_reason() {
>>  
>>  	ovs_drop_record_and_run \
>>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
>> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
>> +	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
>>  	if [[ "$?" -ne "1" ]]; then
>>  		info "Did not detect expected explicit error drops: $?"
>>  		return 1
>> @@ -867,7 +858,7 @@ test_drop_reason() {
>>  
>>  	ovs_drop_record_and_run \
>>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
>> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
>> +	ovs_drop_reason_count OVS_DROP_EXPLICIT
>>  	if [[ "$?" -ne "1" ]]; then
>>  		info "Did not detect expected explicit drops: $?"
>>  		return 1
>>
> 
> No longer untested, that works.

Looks nicer than parsing obscure numbers indeed!

Matthieu mentioned we'll need CONFIG_TRACEPOINTS in the selftest config
shard: tools/testing/selftests/net/openvswitch/config

Is that a new dependency or was it always there we just missed adding it
to the config before?  (it's included in the common net config, so that
is probably the reason why CI doesn't fail)

Best regards, Ilya Maximets.
