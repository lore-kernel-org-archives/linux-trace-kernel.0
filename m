Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407308;
	b=SHTcqpNl66SmaYwyKrLUHCPh6xnjvY8FC9QgnCdN4mwvOMAg3+mCjsjCobf9LwPJrd/f
	 DXZQSN5lYh+KulfAgPR0aUNQ+vmFxVh22NcyZ3oDokF88R7CIpuekRmA5lyl1xS+rsNLV
	 oUBJF/rDMxm+Cr3KNx2xss9jsSPAGPLkhrrUut0Ktoo3yVizdCg1iIz77fFZJJnyMdfUY
	 zUKidBMqKmYYR19p9krZSDtdM6SVUKQVNfaKtpdq04sZjI8uunpGmTpdllkUhMgIlmy/j
	 izb74hYQm3+pHoB/w1Y0/a6THKSQK+AQ3EBha6NODf1UPmqs3J1cO+/fOc//TypgVxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407308;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:
	 CFBL-Address:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3QGxftQLxKTSOBvApzYyCE8MPukN07SFGrj9IZ2HX7c=;
	b=UvTaStI8Xc2bIayKZxw6a1RALrahHunCtxei5SdX6Za2x7bqn8d7Q1EN8sWlztgUR+7o
	 zOfRSMg7pqL3HuQSKKBz1vVwxNq3dKmswTcMTnBaHv13Q3h897+q/X1MYOsPdgSvCpcko
	 v4RUqcSxuFkmC3pWe90HlIWb5bWidFsuJKg4HwliFCxYDhQYcvvBo80oHADrtr/20BB3g
	 PMmQ0jLvcnyWbGz0HtPCkbJDumDU9cpxA7MWXW0yKH30Tkng2P1jMO3TXb7ojrnJuvjfs
	 kRFNUrvaj+QoLxrxk+uSin5aWYjHc7nH/nY8/TuoMnfHxuLjsHSuZPFjDJoZHev34HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ovn.org;
	spf=pass smtp.mailfrom=fe-bounces.ovn.org;
	dkim=pass header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=I8evzlW8;
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=UF57ilPY;
	arc=none smtp.remote-ip=121.127.44.73
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD9606A333
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 04:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBBD9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ovn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovn.org header.i=@ovn.org header.a=rsa-sha256 header.s=fe-13eddc7e57 header.b=I8evzlW8;
	dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=UF57ilPY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovn.org;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: Autocrypt: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-13eddc7e57;
 t=1795407307; bh=3QGxftQLxKTSOBvApzYyCE8MPukN07SFGrj9IZ2HX7c=;
 b=I8evzlW8F6LHjaewHupTrqsLO+7DEGwHTuT5Rs7GKxkKJBphSIpJvuu2YrTVxBiOMG3FIR3RH
 mcSsu91IGIK3y2mzEh3VZC07DjNJOvFe2uWlbj8AMEsJ0O07QG7Rpw9WH0EE4ZRRGLyjOcdVuyP
 jNY3bbrVoZDotunT4FVyY1s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: Autocrypt: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1795407307; bh=3QGxftQLxKTSOBvApzYyCE8MPukN07SFGrj9IZ2HX7c=;
 b=UF57ilPYJXcH/4byHzSDtWIZ3tbg/jrEdesx2ADBOnM+OIEwLRKuyFx1zAn4or7e1jNll17xe
 oqfz8EdzGHC0gbo3V1Asm30TW5+NCoIrWh8kwPNx5CV450egc81EakQtSVc2Of73Qf2ZyNrm0ry
 o6IoTNHUSc0nCYVBHo+iLl0=
CFBL-Feedback-ID: 6b03bdca9ac7a1bf66975566:d42d2194a37096a761e7117f94e43a90
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b03bdca9ac7a1bf66975566
X-Forward-Email-Sender: rfc822; i.maximets@ovn.org, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fe3d59b0-d5cc-4b54-8339-35c30bb86036@ovn.org>
Date: Mon, 23 Nov 2026 05:15:02 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] net: dropreason: use new __print_sym() in tracing
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
References: <20261119155133.355849-6-johannes@sipsolutions.net>
 <20261119155133.355849-9-johannes@sipsolutions.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20261119155133.355849-9-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 4:48 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The __print_symbolic() could only ever print the core
> drop reasons, since that's the way the infrastructure
> works. Now that we have __print_sym() with all the
> advantages mentioned in that commit, convert to that
> and get all the drop reasons from all subsystems. As
> we already have a list of them, that's really easy.
> 
> This is a little bit of .text (~100 bytes in my build)
> and saves a lot of .data (~17k).
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v7: update the selftest accordingly
> ---
>  include/net/dropreason.h                      |  5 +++
>  include/trace/events/skb.h                    | 13 ++----
>  net/core/skbuff.c                             | 43 +++++++++++++++++++
>  .../selftests/net/openvswitch/openvswitch.sh  | 17 ++------
>  4 files changed, 55 insertions(+), 23 deletions(-)

[...]

> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 21444657a040..b5dbdfb29089 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -236,7 +236,7 @@ ovs_drop_reason_count()
>  	local reason=$1
>  
>  	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
> -	local pattern="skb:kfree_skb:.*reason: $reason"
> +	local pattern="skb:kfree_skb:.*reason: $reason$"
>  
>  	return `echo "$perf_output" | grep "$pattern" | wc -l`
>  }
> @@ -900,15 +900,6 @@ test_psample() {
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
> @@ -952,7 +943,7 @@ test_drop_reason() {
>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
>  
>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
> +	ovs_drop_reason_count OVS_DROP_LAST_ACTION
>  	if [[ "$?" -ne "2" ]]; then
>  		info "Did not detect expected drops: $?"
>  		return 1
> @@ -969,7 +960,7 @@ test_drop_reason() {
>  
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
> +	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit error drops: $?"
>  		return 1
> @@ -977,7 +968,7 @@ test_drop_reason() {
>  
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
> +	ovs_drop_reason_count OVS_DROP_EXPLICIT
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit drops: $?"
>  		return 1

For the OVS test part:

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
