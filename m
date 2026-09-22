Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8523EAC74
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087801; cv=none; b=e08mC59jVV1YhQZNFyZQJZnkrZOCZd99ntvJlSrGkH3CX+TTbBaHgsD9wEtyZqacFiI2CGBJSxCtPeoAUQChPEJNJIZ7B1beJqkOIqxLMvRLfCGWhIMrpwiHuU/7kEwiWPKiwGOZ/4fF7F1Du62XJCSBoHmAW51e+5jbyWYnuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087801; c=relaxed/simple;
	bh=wm1mdUOdPY+A9xm9DAzxZQGN1bfMmm1ggAop9ZSmO7M=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5Eh0Z6jhxGVp56ZVpkks7FrT0EesUiHz3csTlPnuOa6hb03Ir48Q4SkIP2fQ6qEgs2LQG/BLUOBbs/zzgt80u7+J8XAWgU/aLOjSCyTkKETu0s904rLCXNFs0sAghCjm7gX7A7l7KJ6CFpZC7I/Y0irpevjPb5fkj+ctAi9UKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNt1vtav; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNt1vtav"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790087798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Uhf7XUhU0j+LV6kdzlFblwsBGtqhh56gYh3J+aEB9A=;
	b=QNt1vtavmpZlABfNx2Yq+vtV9+MwkpO91vEQen/sKFxbaX2wpvUsVsQk6fh9ybKNqmrzoE
	8HvJ0MwJNe31c91CtAnHHMMFoPMKyREX2Futu6nCC4YyMZl/Pj3u4Ph+j34zxIm628lsqP
	5rms2YgHyPWZ7rUnLKEU6qRWQMY0w5k=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-dKpjcPzCPGGosXfkYMxHSg-1; Tue, 22 Sep 2026 10:36:37 -0400
X-MC-Unique: dKpjcPzCPGGosXfkYMxHSg-1
X-Mimecast-MFC-AGG-ID: dKpjcPzCPGGosXfkYMxHSg_1790087796
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66c70f5abc2so3568395d50.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 07:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087796; x=1790692596;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:mime-version
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Uhf7XUhU0j+LV6kdzlFblwsBGtqhh56gYh3J+aEB9A=;
        b=MQo+c/D3uwwcVPik0xi5Yh5Xbq3GSAYflBLE8FqSg0aM4SFbzHuTkvZaVMPvR+YJBn
         I6FihsAYdqbxb7xJtWr8Pta6CNJYVVXkDyeUlWJh4s+nAs92YnTAsAljpuKtN61pF0zq
         5g1rGvGtma4zZwWen+jyiKYAzPFVIqIIxVymqkuH1ux9gbWIZD0JbVWe95PlBO3AG55j
         iBgTu+ccoTdp6iFdsmLR6v9V/34Ry1syZeFokOimbWC4K3GncQ82Ep2OixDP/DNJeLgR
         hSIR9h6R+0DoddVV/ZzE61pl8S9xkhEpRFVTVbR/ef6Zd8nOYW0DvYJfWmxpTK/tIwNd
         G4Lg==
X-Forwarded-Encrypted: i=1; AKwUvBxBFITlSOwF3G0yr9BqHv9onAS7uuPhi9X44Wjdl+cQYUR0G24I19SCFh7x+96WM3kV/gq3gZkUl6gZH+0wfvgjDYA=@vger.kernel.org
X-Gm-Message-State: AFuF++nuDQyhtEVBjvgjbNN0pjgCn7Xws1ltcjKufgygU9TeMxVEGter
	hymyc8SscbkJXHqsrwQV/9vrdGlO06Htue16kpg4dGzG/pjD2pSrgOtzu9Ove4sGS6+MSnUNEPN
	YNue4ftG+LUPO/BS2x2etPw1L2zaLZb0YDMiNGBjiqVUIqhL5yZVFZ/I25GfNdFj6Yqhr2Kco3Z
	qBAExBPO9Qtxe4aAglajNknzJAHFKvi3Mnch4nd9D6GaGdobNt
X-Gm-Gg: AYBFou1JBTA55pg5TxD487YBrWHlk+ZbKPoSmv7Z1Mcucu1rHLZSH85Iy1IN6mrlZ1b
	nBrgGwoEp7f0NecOLwY3/3snn6hgdTXH+AhTT/OE6WIconmqR1n5pAv11ylO3Zue/n8Q9Hr46cG
	J/JxzXh5eA++m1657hSEWTPLjfki3M64MvLlLD3Wy2zEfQRelkon9ujs4=
X-Received: by 2002:a05:690e:168a:b0:672:c55b:6bec with SMTP id 956f58d0204a3-672c55b76b1mr1249988d50.5.1790087796388;
        Tue, 22 Sep 2026 07:36:36 -0700 (PDT)
X-Received: by 2002:a05:690e:168a:b0:672:c55b:6bec with SMTP id
 956f58d0204a3-672c55b76b1mr1249970d50.5.1790087795940; Tue, 22 Sep 2026
 07:36:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 10:36:32 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 10:36:32 -0400
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net> <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org> <99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
 <4a0240a7b9ff87302620a95c73f4f265cd428618.camel@sipsolutions.net> <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
Date: Tue, 22 Sep 2026 10:36:32 -0400
X-Gm-Features: AclHuK_WQy-H4M9Vjbwisdq6E74XDMCt0MUm8uA9loRbh4lJmNGD-_684UY2a9A
Message-ID: <CAG=2xmOuz6JEqZROE26nHEq5MgwTBNU_PvSqw1sn1MzAohotWg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Antoine Tenart <atenart@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LNIDoxmZFtBi4tAg_vSAYpN9gsge38e8pIkySjIzEOY_1790087796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 22, 2026 at 11:01:10AM +0200, Ilya Maximets wrote:
> On 9/22/26 1:20 AM, Johannes Berg wrote:
> > On Tue, 2026-09-22 at 00:36 +0200, Johannes Berg wrote:
> >>
> >> Indeed. Something like this (untested right now, didn't manage to spin
> >> up a test yet):
> >>
> >> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> >> index a31f7fb6882d..9b8edfcd2d1a 100755
> >> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> >> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> >> @@ -234,7 +234,7 @@ ovs_drop_reason_count()
> >>  	local reason=$1
> >>
> >>  	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
> >> -	local pattern="skb:kfree_skb:.*reason: $reason"
> >> +	local pattern="skb:kfree_skb:.*reason: $reason$"
> >>
> >>  	return `echo "$perf_output" | grep "$pattern" | wc -l`
> >>  }
> >> @@ -790,15 +790,6 @@ test_psample() {
> >>  # - drop packets and verify the right drop reason is reported
> >>  test_drop_reason() {
> >>  	which perf >/dev/null 2>&1 || return $ksft_skip
> >> -	which pahole >/dev/null 2>&1 || return $ksft_skip
> >> -
> >> -	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
> >> -			      awk '/OPENVSWITCH/ { print $3; }' |
> >> -			      tr -d ,)
> >> -	if [ -z "$ovs_drop_subsys" ]; then
> >> -		info "failed to get OVS drop subsys ID"
> >> -		return $ksft_skip
> >> -	fi
> >>
> >>  	sbx_add "test_drop_reason" || return $?
> >>
> >> @@ -842,7 +833,7 @@ test_drop_reason() {
> >>  		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
> >>
> >>  	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
> >> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
> >> +	ovs_drop_reason_count OVS_DROP_LAST_ACTION
> >>  	if [[ "$?" -ne "2" ]]; then
> >>  		info "Did not detect expected drops: $?"
> >>  		return 1
> >> @@ -859,7 +850,7 @@ test_drop_reason() {
> >>
> >>  	ovs_drop_record_and_run \
> >>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
> >> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
> >> +	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
> >>  	if [[ "$?" -ne "1" ]]; then
> >>  		info "Did not detect expected explicit error drops: $?"
> >>  		return 1
> >> @@ -867,7 +858,7 @@ test_drop_reason() {
> >>
> >>  	ovs_drop_record_and_run \
> >>              "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
> >> -	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
> >> +	ovs_drop_reason_count OVS_DROP_EXPLICIT
> >>  	if [[ "$?" -ne "1" ]]; then
> >>  		info "Did not detect expected explicit drops: $?"
> >>  		return 1
> >>
> >
> > No longer untested, that works.
>
> Looks nicer than parsing obscure numbers indeed!

+1, way prettier indeed.

>
> Matthieu mentioned we'll need CONFIG_TRACEPOINTS in the selftest config
> shard: tools/testing/selftests/net/openvswitch/config
>
> Is that a new dependency or was it always there we just missed adding it
> to the config before?  (it's included in the common net config, so that
> is probably the reason why CI doesn't fail)
>
> Best regards, Ilya Maximets.
>

