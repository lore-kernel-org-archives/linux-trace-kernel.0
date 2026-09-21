Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282851B17C;
	Mon, 21 Sep 2026 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030198; cv=none; b=G1PoPhINy/Xt26rdfqG+ojepjrXpPJaVcA3tYc0Rlj6qmV2XthcLRdC3ysQF1LoTu68Jz3YiRkcyQLpeH7R9dz3yflmunqXQvym+lVOWLghwuw4aF0D7QzhM/ObsXirwNAX5VQxcqQf8mmSpxV+hXx0THE62Y5yocb4sGWsP+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030198; c=relaxed/simple;
	bh=LqXpeSE1c+FemqzOE2Mqcaieusn5bFTN6m+eR6wJmJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1K4ApaNNI7in/zRu/dJaBfcdKHlvJvuG++Z8VqGcjxv2QMhjyf9/L3Jlep3Y2KlYmsCZa8FklyH0VRs3bahABOi4o99HuGNuPaoSsKQthVISIit5yrYeN7n8a9QDrcCY7D8GlUy6cVbJvLWxx3d1XdiBOEn5nZy5XmB7k7nc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E+MLJQWD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E+MLJQWD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5c49Nat1hoW03vWkfnbZXF6c6fxzzWAYI2tU6lTcaxE=;
	t=1790030195; x=1791239795; b=E+MLJQWD5ljNjRyh5jH5+8QV9Uey7tKJLkCSThwLkzDEu8I
	jUlzUg2peBDU0GBx5eRREZPQwXPZHezqks2+KV+i7uxDKwPdeQQDdJJEl66CP/XCNYsb4jlvkr4V6
	qIUIRlI0vnDR2EjNvZubAbnwid7uZaXFW3Z7pTJEkLX67SD0HreraP3A9YrO1YL9Z66FzfQLIGEdB
	oLlKN6x+y7Y51pTEDXOCX5A8920DaM8hEUxmMvh7/c3vo1h+AZTnReaIVZRfAusrV2KdILaW80zAT
	731P/XBigwgd+rTWV7omV8Kh2KO6fVHLdoX1vdlGEaXqhoUk+z5lZzQ1ooDOtTtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8mcd-0000000687I-1glj;
	Tue, 22 Sep 2026 00:36:27 +0200
Message-ID: <99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
From: Johannes Berg <johannes@sipsolutions.net>
To: Ilya Maximets <i.maximets@ovn.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron	 <echaudro@redhat.com>,
 dev@openvswitch.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Adrian Moreno	
 <amorenoz@redhat.com>, Antoine Tenart <atenart@kernel.org>
Date: Tue, 22 Sep 2026 00:36:26 +0200
In-Reply-To: <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org> (sfid-20260922_002359_374467_DCE67D5E)
References: <20260921101538.97286-6-johannes@sipsolutions.net>
	 <20260921101538.97286-9-johannes@sipsolutions.net>
	 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
	 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
	 (sfid-20260922_002359_374467_DCE67D5E)
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

Hi,

Yeah, Jakub pointed this out too ...=20

It's because the test explicitly tries to figure out the right _number_
that openvswitch will use in the drop reasons - had I not slept on this
infrastructure for two years, the test would probably have been written
a lot simpler to start with ;-)

> > https://netdev-ctrl.bots.linux.dev/logview.html?f=3D%2Flogs%2Fvmksft%2F=
net%2Fresults%2F833743%2F9-openvswitch-sh%2Fstdout#L168
> >=20
> > Maybe the test needs to be adapted to get the same info differently?
> > (and adding CONFIG_TRACEPOINTS to the selftest config file)
> The parsing in the test will definitely need to be updated, i.e.,
> the numbers swapped with the names of the drop reasons.

Indeed. Something like this (untested right now, didn't manage to spin
up a test yet):

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools=
/testing/selftests/net/openvswitch/openvswitch.sh
index a31f7fb6882d..9b8edfcd2d1a 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -234,7 +234,7 @@ ovs_drop_reason_count()
 	local reason=3D$1
=20
 	local perf_output=3D`perf script -i ${ovs_dir}/perf.data -F trace:event,t=
race`
-	local pattern=3D"skb:kfree_skb:.*reason: $reason"
+	local pattern=3D"skb:kfree_skb:.*reason: $reason$"
=20
 	return `echo "$perf_output" | grep "$pattern" | wc -l`
 }
@@ -790,15 +790,6 @@ test_psample() {
 # - drop packets and verify the right drop reason is reported
 test_drop_reason() {
 	which perf >/dev/null 2>&1 || return $ksft_skip
-	which pahole >/dev/null 2>&1 || return $ksft_skip
-
-	ovs_drop_subsys=3D$(pahole -C skb_drop_reason_subsys |
-			      awk '/OPENVSWITCH/ { print $3; }' |
-			      tr -d ,)
-	if [ -z "$ovs_drop_subsys" ]; then
-		info "failed to get OVS drop subsys ID"
-		return $ksft_skip
-	fi
=20
 	sbx_add "test_drop_reason" || return $?
=20
@@ -842,7 +833,7 @@ test_drop_reason() {
 		"in_port(2),eth(),eth_type(0x0800),ipv4(src=3D172.31.110.20,proto=3D1),i=
cmp()" 'drop'
=20
 	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2=
 172.31.110.20
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
+	ovs_drop_reason_count OVS_DROP_LAST_ACTION
 	if [[ "$?" -ne "2" ]]; then
 		info "Did not detect expected drops: $?"
 		return 1
@@ -859,7 +850,7 @@ test_drop_reason() {
=20
 	ovs_drop_record_and_run \
             "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.11=
0.20 6000
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION=
_ERROR
+	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
 	if [[ "$?" -ne "1" ]]; then
 		info "Did not detect expected explicit error drops: $?"
 		return 1
@@ -867,7 +858,7 @@ test_drop_reason() {
=20
 	ovs_drop_record_and_run \
             "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.11=
0.20 7000
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
+	ovs_drop_reason_count OVS_DROP_EXPLICIT
 	if [[ "$?" -ne "1" ]]; then
 		info "Did not detect expected explicit drops: $?"
 		return 1


> IIUC, this change only affects the printing and doesn't affect debugging
> tools like retis that attempt to surface the drop reasons.  But, maybe
> Adrian and Antoine (CCed) may want to have a glance as well.

Not sure how those work? But unless it's interacting with the text
output of trace-cmd report or perf like here, it probably won't care?

johannes
