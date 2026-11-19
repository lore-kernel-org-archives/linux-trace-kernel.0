Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103505;
	b=rCJK0/vB1kEKL3p77yq57WHNoTi9q1vLWCkSH58I7cqJnKaBZdNX6EVL9T2zFFb6sPya
	 coaLRhB0J6yO4sdkshuxPp7eUtt+Cf80IrFmPRbdTawngFtAadsVL9jYG1ij9d2FAO1zU
	 TuPc3zBVxAldilXhKg4X2ftV5oBpPQTWUuWPqQ+YAj4CZKv10jZ8R7/yEOl/oDErvjmgn
	 PSrSlQTEC6FJh99oYC1FwgdoLLsBmdYSufCo+C1iDE4hp2E2wXPd5eZaiQDTou6qw0uXU
	 TY0prkaFRF4VS5n1xkzgflFK6oKAFgl/KAqOChmPpMAq6F3XPE6xYF5g2SOP6iS/tSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103505;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hyPX0C05KvCDtaqKj+Y4sswwa5Hne5NGftXINQugC9g=;
	b=Vczvnh6xtpSQuSFpiK7Yk8AfPtKgiw/gQvHSzbnXSyytrYkv/EbiyhVS6jZZ0oy9jkk2
	 D/h+TZwiT49SBnutnrbwpi8C6Sc0lhz8nLCJoBQelk2dkmn3zDkIHtlKa398yj9tUCNH4
	 JAnz7iK2pr5XzhBRbGvNXPnrZrFMyXwR6coyP8gfEMXZJMJqji9jDEcybxAgZG9QCf1Ko
	 F9NhYlwNtv+iV/svuNBtzDFXuBhclJk3MeB9i5SxhniwwqAjLDbEC50EVxHPYotUzJCfL
	 rnGrfM9X/BHuDKLhOD24sQMyDpihR97VDC6Irc/j/2Qd7yILZebchazEHUspn02NDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=aNes48JM;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BC60A3819;
	Thu, 19 Nov 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=aNes48JM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hyPX0C05KvCDtaqKj+Y4sswwa5Hne5NGftXINQugC9g=;
	t=1795103504; x=1796313104; b=aNes48JMbw5ijcnXkbsd2QizUtHNXVv3TXuMz2hjfiS3oPD
	wY9677s/rs+fv9xB+4m0N4B8bLX91S58d3Ghahij1/9mERdicrl6+jStl3p7RiFMoav9wWOakl/Cs
	zlCaf1lNmdtcO60xj4KdvUwvDY4Aye/V6v1iPKg4LduAWGmpmNaVnBquCVrJfhskXRivwxEcXrRTj
	FzUS1VlSBUT0A7uR7qOtfMB1oAV2/w8RjiBAmQWAZnksKBY6IsCLPZonI85yq+dUGMYyEe9gvSHsv
	urvW4rc3pDPd00v+sq2bGvP3fLFc6GeB0aK/bIOyohfJWljyItxhXDjPP/ampEqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU4QF-00000004ZOV-3GPi;
	Thu, 19 Nov 2026 16:51:39 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v8 3/4] net: dropreason: use new __print_sym() in tracing
Date: Thu, 19 Nov 2026 16:48:43 +0100
Message-ID: <20261119155133.355849-9-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119155133.355849-6-johannes@sipsolutions.net>
References: <20261119155133.355849-6-johannes@sipsolutions.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The __print_symbolic() could only ever print the core
drop reasons, since that's the way the infrastructure
works. Now that we have __print_sym() with all the
advantages mentioned in that commit, convert to that
and get all the drop reasons from all subsystems. As
we already have a list of them, that's really easy.

This is a little bit of .text (~100 bytes in my build)
and saves a lot of .data (~17k).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v7: update the selftest accordingly
---
 include/net/dropreason.h                      |  5 +++
 include/trace/events/skb.h                    | 13 ++----
 net/core/skbuff.c                             | 43 +++++++++++++++++++
 .../selftests/net/openvswitch/openvswitch.sh  | 17 ++------
 4 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index 1df60645fb27..dc4a60130c09 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -42,6 +42,11 @@ struct drop_reason_list {
 extern const struct drop_reason_list __rcu *
 drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
 
+#ifdef CONFIG_TRACEPOINTS
+const char *drop_reason_lookup(unsigned long long value);
+void drop_reason_show(struct seq_file *m);
+#endif
+
 void drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
 				  const struct drop_reason_list *list);
 void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys);
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 2945aa7fe9a7..991bf172a6ea 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -8,15 +8,9 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/tracepoint.h>
+#include <net/dropreason.h>
 
-#undef FN
-#define FN(reason)	TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
-DEFINE_DROP_REASON(FN, FN)
-
-#undef FN
-#undef FNe
-#define FN(reason)	{ SKB_DROP_REASON_##reason, #reason },
-#define FNe(reason)	{ SKB_DROP_REASON_##reason, #reason }
+TRACE_DEFINE_SYM_FNS(drop_reason, drop_reason_lookup, drop_reason_show);
 
 /*
  * Tracepoint for free an sk_buff:
@@ -47,8 +41,7 @@ TRACE_EVENT(kfree_skb,
 	TP_printk("skbaddr=%p rx_sk=%p protocol=%u location=%pS reason: %s",
 		  __entry->skbaddr, __entry->rx_sk, __entry->protocol,
 		  __entry->location,
-		  __print_symbolic(__entry->reason,
-				   DEFINE_DROP_REASON(FN, FNe)))
+		  __print_sym(__entry->reason, drop_reason))
 );
 
 #undef FN
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1ac1e327ac4c..d83d89e310de 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -155,6 +155,49 @@ drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
 };
 EXPORT_SYMBOL(drop_reasons_by_subsys);
 
+#ifdef CONFIG_TRACEPOINTS
+const char *drop_reason_lookup(unsigned long long value)
+{
+	unsigned long long subsys_id = value >> SKB_DROP_REASON_SUBSYS_SHIFT;
+	u32 reason = value & ~SKB_DROP_REASON_SUBSYS_MASK;
+	const struct drop_reason_list *subsys;
+
+	if (subsys_id >= SKB_DROP_REASON_SUBSYS_NUM)
+		return NULL;
+
+	subsys = rcu_dereference(drop_reasons_by_subsys[subsys_id]);
+	if (!subsys)
+		return NULL;
+	if (reason >= subsys->n_reasons)
+		return NULL;
+	return subsys->reasons[reason];
+}
+
+void drop_reason_show(struct seq_file *m)
+{
+	u32 subsys_id;
+
+	rcu_read_lock();
+	for (subsys_id = 0; subsys_id < SKB_DROP_REASON_SUBSYS_NUM; subsys_id++) {
+		const struct drop_reason_list *subsys;
+		u32 i;
+
+		subsys = rcu_dereference(drop_reasons_by_subsys[subsys_id]);
+		if (!subsys)
+			continue;
+
+		for (i = 0; i < subsys->n_reasons; i++) {
+			if (!subsys->reasons[i])
+				continue;
+			seq_printf(m, ", { %u, \"%s\" }",
+				   (subsys_id << SKB_DROP_REASON_SUBSYS_SHIFT) | i,
+				   subsys->reasons[i]);
+		}
+	}
+	rcu_read_unlock();
+}
+#endif
+
 /**
  * drop_reasons_register_subsys - register another drop reason subsystem
  * @subsys: the subsystem to register, must not be the core
diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 21444657a040..b5dbdfb29089 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -236,7 +236,7 @@ ovs_drop_reason_count()
 	local reason=$1
 
 	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
-	local pattern="skb:kfree_skb:.*reason: $reason"
+	local pattern="skb:kfree_skb:.*reason: $reason$"
 
 	return `echo "$perf_output" | grep "$pattern" | wc -l`
 }
@@ -900,15 +900,6 @@ test_psample() {
 # - drop packets and verify the right drop reason is reported
 test_drop_reason() {
 	which perf >/dev/null 2>&1 || return $ksft_skip
-	which pahole >/dev/null 2>&1 || return $ksft_skip
-
-	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
-			      awk '/OPENVSWITCH/ { print $3; }' |
-			      tr -d ,)
-	if [ -z "$ovs_drop_subsys" ]; then
-		info "failed to get OVS drop subsys ID"
-		return $ksft_skip
-	fi
 
 	sbx_add "test_drop_reason" || return $?
 
@@ -952,7 +943,7 @@ test_drop_reason() {
 		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
 
 	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
+	ovs_drop_reason_count OVS_DROP_LAST_ACTION
 	if [[ "$?" -ne "2" ]]; then
 		info "Did not detect expected drops: $?"
 		return 1
@@ -969,7 +960,7 @@ test_drop_reason() {
 
 	ovs_drop_record_and_run \
             "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
+	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
 	if [[ "$?" -ne "1" ]]; then
 		info "Did not detect expected explicit error drops: $?"
 		return 1
@@ -977,7 +968,7 @@ test_drop_reason() {
 
 	ovs_drop_record_and_run \
             "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
+	ovs_drop_reason_count OVS_DROP_EXPLICIT
 	if [[ "$?" -ne "1" ]]; then
 		info "Did not detect expected explicit drops: $?"
 		return 1
-- 
2.56.1

