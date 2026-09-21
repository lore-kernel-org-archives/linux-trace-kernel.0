Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD14279F8;
	Mon, 21 Sep 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032850; cv=none; b=EPSAyGENWD4SZ8I+U/oT3itLkeS6XNaYXoFDO4PqM7rKMTNsn8J1PXMCCDQKy9JQPPEF0fFOzH6EAs4TYf9mkW8gAa22a2BGTOvwQ/Zl0t3BNFHkcw7MrgHlzFCq4Qn9NNlwa9PW/N5KnCWkbbd7ARz+T7tBMEvEHAcieTBdKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032850; c=relaxed/simple;
	bh=I8QurwjP3QB4ra+BZpKFn2F56cD706bsO9/irsbGN90=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liutD5lf3V9FeqLDsRZQFUKRknn1kLQVjOGIePnCQ5JXM8konvHabEowUEq3j8q9C7iNfFd/UIw6sHBkIk0REoVXS/UJ37cN/U0BtihThfaxXpPdwcc9n8CCdUuM+ESjljUJ1ACx1hKPV3j0qb9Uncwdiz7L8Bq85gmSn8lM2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iQ2g6fBF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iQ2g6fBF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bnzNQlUPAqEqRUkX0JQghfZNPrTJnLP49/ixQIya5nU=;
	t=1790032848; x=1791242448; b=iQ2g6fBFZZejiRkIRfri67RbIRunWSxTvF/alrhjwg9DYbI
	k5PMbKiLGygjq1FAS4/SjX3qIjkeYEZhTlkRvzNE1K+xa7snouzg3+TL+SzN1PFm3dAq4uBQiqDeT
	wsVZNS7FdwN0NfMArQKaDBhInHywVPlfIMfHqWALC/03fGYaabKlsVQ0mswpQHv2dwQ8c1K3Ssofz
	JkMADtP1iPGcshIudp3ZNnetj9UYQg0J9nkqzFew1+DJ47OCxkVYpREwD4fdGZLgbhQnBKk1h1kCU
	1vUgkJ8NWOQ3FXsPVjGrOdRTKv51nrkAd0Fkb/RmR9Y3t1r11EUolhhEKVbNrjgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8nJR-000000069H1-1BjS;
	Tue, 22 Sep 2026 01:20:41 +0200
Message-ID: <4a0240a7b9ff87302620a95c73f4f265cd428618.camel@sipsolutions.net>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
From: Johannes Berg <johannes@sipsolutions.net>
To: Ilya Maximets <i.maximets@ovn.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron	 <echaudro@redhat.com>,
 dev@openvswitch.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Adrian Moreno	
 <amorenoz@redhat.com>, Antoine Tenart <atenart@kernel.org>
Date: Tue, 22 Sep 2026 01:20:40 +0200
In-Reply-To: <99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
		 <20260921101538.97286-9-johannes@sipsolutions.net>
		 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
		 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
		 (sfid-20260922_002359_374467_DCE67D5E) <99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-09-22 at 00:36 +0200, Johannes Berg wrote:
>=20
> Indeed. Something like this (untested right now, didn't manage to spin
> up a test yet):
>=20
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/too=
ls/testing/selftests/net/openvswitch/openvswitch.sh
> index a31f7fb6882d..9b8edfcd2d1a 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -234,7 +234,7 @@ ovs_drop_reason_count()
>  	local reason=3D$1
> =20
>  	local perf_output=3D`perf script -i ${ovs_dir}/perf.data -F trace:event=
,trace`
> -	local pattern=3D"skb:kfree_skb:.*reason: $reason"
> +	local pattern=3D"skb:kfree_skb:.*reason: $reason$"
> =20
>  	return `echo "$perf_output" | grep "$pattern" | wc -l`
>  }
> @@ -790,15 +790,6 @@ test_psample() {
>  # - drop packets and verify the right drop reason is reported
>  test_drop_reason() {
>  	which perf >/dev/null 2>&1 || return $ksft_skip
> -	which pahole >/dev/null 2>&1 || return $ksft_skip
> -
> -	ovs_drop_subsys=3D$(pahole -C skb_drop_reason_subsys |
> -			      awk '/OPENVSWITCH/ { print $3; }' |
> -			      tr -d ,)
> -	if [ -z "$ovs_drop_subsys" ]; then
> -		info "failed to get OVS drop subsys ID"
> -		return $ksft_skip
> -	fi
> =20
>  	sbx_add "test_drop_reason" || return $?
> =20
> @@ -842,7 +833,7 @@ test_drop_reason() {
>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.20,proto=3D1)=
,icmp()" 'drop'
> =20
>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c=
 2 172.31.110.20
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
> +	ovs_drop_reason_count OVS_DROP_LAST_ACTION
>  	if [[ "$?" -ne "2" ]]; then
>  		info "Did not detect expected drops: $?"
>  		return 1
> @@ -859,7 +850,7 @@ test_drop_reason() {
> =20
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.=
110.20 6000
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTI=
ON_ERROR
> +	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit error drops: $?"
>  		return 1
> @@ -867,7 +858,7 @@ test_drop_reason() {
> =20
>  	ovs_drop_record_and_run \
>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.=
110.20 7000
> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTI=
ON
> +	ovs_drop_reason_count OVS_DROP_EXPLICIT
>  	if [[ "$?" -ne "1" ]]; then
>  		info "Did not detect expected explicit drops: $?"
>  		return 1
>=20

No longer untested, that works.

I might resend tomorrow, but we'll have to wait for Steven to comment on
patches 1-3 anyway.

johannes
