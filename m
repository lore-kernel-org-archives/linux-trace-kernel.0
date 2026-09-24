Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3C4A3F0B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263907; cv=none; b=lOJn21z0vMMkKjdUcaOP2NvcUc7DOalcAfKFDpgcoEhnOsRJST3VhDU+kuRChPn/RuttYFytac9v7flsiCk5l7Udj4Psoi2WN9qFaxJZ93I7zvY413f4jXmhd4n26mvVjSioGzGt5yBw1ga88JhvFev3P7ZZNOw8rUFp8+Top50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263907; c=relaxed/simple;
	bh=7wA4tIZDQ1H3vJCB7dAc60HbH9dG6Y2RrMapWjovrUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8dnNcT4G5Nt+EDXdiFu6DrFs+dmoNwIZrx4jxF1G3IGoqtRWthUKvAdI2lP6dMuowWGo7jj7z8btjK0atb/1OQet1DJ3/pcD8zHUV9NUG0ZXxDr7xaRDEYj4gCjWWCnUQVJdQ1op0/tIxbvXmtCSvoM9FkSE1mt87XPnhDBNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6e43b9d8so6430385e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 08:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263903; x=1790868703;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8sKQnNLa4+czjyU7qVaxtnFrvWhIKj5DHPdLUkSR5M=;
        b=hluTVSEYjjthGXqhiYykxVv8Qd5GoVpf03kZLc9QMZdy6jOqBg6I7PyfDzY0ZBCRCG
         ABmJkQBJqDpqBrQZL7SBt78CAStGflRoe6KRJOOm6NYiDg2ySVyr12ELQGwqU6Wyy+Dn
         nekpg3K5g9uanwoXNG04hoxjKliGW6gCYz2GuSsSvFW+bhcvrCJ9xvEI6A/AHi/tM/zR
         sEdfDe2BJCMQZoYl9hphCbhuTqIYdrVgWJOaa6oOov4EecQDs7DTlSv7Kb4lcAOjnVf4
         5TKwfcHe2DebKL5t04FQc7GIKKgui/uJB0ebqEBlKuMGvlQvzIZ0P7z6PuNqocydw0oP
         P1PA==
X-Forwarded-Encrypted: i=1; AKwUvBymUx8w3bHGx0uWC137zs7HZk97wVPlksGXOdUrJHf2aa21FkbuesrAN4GrBn69DqNDa3wWEdglW/RJ48qz9yB2/og=@vger.kernel.org
X-Gm-Message-State: AFuF++mWlxss/1egvDfO8YhoOwz9r5qfUKQ/jTsmlP8XPZFLp6lfE6Bj
	mrALyJqgxca9SH/J2TnbxRYLBDIq3djPHmSd8hwytYAXZHHhPeNQKfFM
X-Gm-Gg: AYBFou0KmEkbFv8O5yqPpflsSjpX08doGchuAzwUTQpJQ++zgSGx7qGZwkmJyE75i61
	t+ThVyOyJ/RxeqVTOLSdWZbJbtDnBkMlbbWvBWA9Co34XQiivMW1XCL8IAJeeDRicu0S6NG0Dl8
	epJd1dTL4nN3qFHLclbXyKt9CZgHeYIlaQvanzAKTFyxh9nf2nrXz4sOQCtA6w2/a/PlqNd+b2J
	5O4IbxPjenNKKu2pxXcAqig2mhAJVkTkka8kfrdWHY6myztpkQK7oqklYnrQsWOdTj8tB7wvVye
	U4U+ZUwAyIlJYhqyXbPgJr+rw7iy4jiq7GXd3xUe42rOOz2xbfkfo/WlxxyoSvtPueCbhj093Q0
	iVrel0j5sgCgZbauyMbcNgho9GUMJhFZr/cjOeqOZIkrS74EDlx/T3QY0aRZ48tSodh+Re6YAGQ
	wAWlHC6SmBk50VBV9NvnGHB3RI5XECo7JKnBsK6fLfmP0bI67eBG5+X/MubYrnO7isYHYoxH4+s
	9/t13GFYO2LZH/ZPSuYtljZbnSKeSaYLLqOlvKCsBtj0cE=
X-Received: by 2002:a05:600c:1906:b0:49f:bd3c:bc25 with SMTP id 5b1f17b1804b1-49fe67107d1mr49330485e9.32.1790263903010;
        Thu, 24 Sep 2026 08:31:43 -0700 (PDT)
Received: from [192.168.88.241] (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf3541aesm93335605e9.0.2026.09.24.08.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:31:42 -0700 (PDT)
Message-ID: <118612d5-8b21-4249-81e2-5dcb60a12a9d@ovn.org>
Date: Thu, 24 Sep 2026 17:31:39 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] net: dropreason: use new __print_sym() in tracing
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ilya Maximets <i.maximets@ovn.org>, Matthieu Baerts <matttbe@kernel.org>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, Adrian Moreno <amorenoz@redhat.com>,
 Antoine Tenart <atenart@kernel.org>, Johannes Berg <johannes.berg@intel.com>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
 <20260922110955.363677-9-johannes@sipsolutions.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260922110955.363677-9-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 1:08 PM, Johannes Berg wrote:
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index a31f7fb6882d..9b8edfcd2d1a 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -234,7 +234,7 @@ ovs_drop_reason_count()
>  	local reason=$1
>  
>  	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
> -	local pattern="skb:kfree_skb:.*reason: $reason"
> +	local pattern="skb:kfree_skb:.*reason: $reason$"
>  
>  	return `echo "$perf_output" | grep "$pattern" | wc -l`
>  }
> @@ -790,15 +790,6 @@ test_psample() {
>  # - drop packets and verify the right drop reason is reported
>  test_drop_reason() {
>  	which perf >/dev/null 2>&1 || return $ksft_skip
> -	which pahole >/dev/null 2>&1 || return $ksft_skip
> -
> -	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
> -			      awk '/OPENVSWITCH/ { print $3; }' |
> -			      tr -d ,)
> -	if [ -z "$ovs_drop_subsys" ]; then
> -		info "failed to get OVS drop subsys ID"
> -		return $ksft_skip
> -	fi
>  
>  	sbx_add "test_drop_reason" || return $?
>  
> @@ -842,7 +833,7 @@ test_drop_reason() {
>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
>  
>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
> +	ovs_drop_reason_count OVS_DROP_LAST_ACTION
>  	if [[ "$?" -ne "2" ]]; then
>  		info "Did not detect expected drops: $?"
>  		return 1
> @@ -859,7 +850,7 @@ test_drop_reason() {
>  
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
> +	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit error drops: $?"
>  		return 1
> @@ -867,7 +858,7 @@ test_drop_reason() {
>  
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
> +	ovs_drop_reason_count OVS_DROP_EXPLICIT
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit drops: $?"
>  		return 1

For the test:

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
