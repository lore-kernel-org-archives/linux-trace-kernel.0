Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668353978D;
	Tue, 22 Sep 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075412; cv=none; b=XSdzl9c+R1S8d/1veYu43HMvax7qw+TKKn39Y1bEkcyCETPoqjspBY7iy1VgvpCNl7ckWFrdpgpztNVyKYWsKihYUY1IT3xzSQ2iqUE1+rSo47KiFJTVdd1JP30/ClQHggfvxUlYmkv3xMPndO7/mUjwcNdlnyYymf42ok9Y++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075412; c=relaxed/simple;
	bh=DZgZvrw/+5D9TnhHWr+3HmfmfML+adpHNyCbQvC9eK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmdCvGs2UecZaW5IjkRJUJTWRAQuzPCojmm/SzDcmAYED7oPsjSlGZrFwokL4SnTsnM3h97qw8iFgKkNhMoANi5+Jux60IZZIg+3oOyIcN71rqYYz+ICmcOZEBC+O4WPkxv0aem6aHPocrNciIAhRG6eV6egh4ej2i8fPqWjsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UDxSqGlv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UDxSqGlv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HOgFPgD4DC03gxQwx5pH0/2BpK5RRoQfCZnIS6bmzGY=;
	t=1790075409; x=1791285009; b=UDxSqGlv6BY/ymWwVr7WGPnuWYZSoxl1CU+dPcm5WG7h6lY
	O5dh2jkghO1QJ76m2uSwEdSo5u9eq9foGwAU4V4gd0pzIaxddSLGZDO3tXBBl6J7YgEJ8bM8AOY6g
	GKOfICZzEjRDfYd27+YMTuKel5awzNjMyI8sYO9APn4w0PgK3GpZM1B/JeEK1YxiG6ZaoKDrpxrXT
	3+ch1/6Q2d5mIo04XcrEReuvrTisevpXWVv2VYyCE5XbKFtenayGYn2x2ozpWz9aVvnckzaqEa3YM
	pYycXoh168dUFsVYHIbcdOL5k98Si4lthmcR2Rp0EUxUtk8YRr5RV/xh8/RyyHPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8yNv-00000006qo8-2qmM;
	Tue, 22 Sep 2026 13:10:03 +0200
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
Subject: [PATCH v7 3/4] net: dropreason: use new __print_sym() in tracing
Date: Tue, 22 Sep 2026 13:08:42 +0200
Message-ID: <20260922110955.363677-9-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110955.363677-6-johannes@sipsolutions.net>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
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
index dbbe10277d51..8c8f7a05dea4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -154,6 +154,49 @@ drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
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
index a31f7fb6882d..9b8edfcd2d1a 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -234,7 +234,7 @@ ovs_drop_reason_count()
 	local reason=$1
 
 	local perf_output=`perf script -i ${ovs_dir}/perf.data -F trace:event,trace`
-	local pattern="skb:kfree_skb:.*reason: $reason"
+	local pattern="skb:kfree_skb:.*reason: $reason$"
 
 	return `echo "$perf_output" | grep "$pattern" | wc -l`
 }
@@ -790,15 +790,6 @@ test_psample() {
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
 
@@ -842,7 +833,7 @@ test_drop_reason() {
 		"in_port(2),eth(),eth_type(0x0800),ipv4(src=172.31.110.20,proto=1),icmp()" 'drop'
 
 	ovs_drop_record_and_run "test_drop_reason" ip netns exec client ping -c 2 172.31.110.20
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0001 # OVS_DROP_FLOW_ACTION
+	ovs_drop_reason_count OVS_DROP_LAST_ACTION
 	if [[ "$?" -ne "2" ]]; then
 		info "Did not detect expected drops: $?"
 		return 1
@@ -859,7 +850,7 @@ test_drop_reason() {
 
 	ovs_drop_record_and_run \
             "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 6000
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0004 # OVS_DROP_EXPLICIT_ACTION_ERROR
+	ovs_drop_reason_count OVS_DROP_EXPLICIT_WITH_ERROR
 	if [[ "$?" -ne "1" ]]; then
 		info "Did not detect expected explicit error drops: $?"
 		return 1
@@ -867,7 +858,7 @@ test_drop_reason() {
 
 	ovs_drop_record_and_run \
             "test_drop_reason" ip netns exec client nc -i 1 -zuv 172.31.110.20 7000
-	ovs_drop_reason_count 0x${ovs_drop_subsys}0003 # OVS_DROP_EXPLICIT_ACTION
+	ovs_drop_reason_count OVS_DROP_EXPLICIT
 	if [[ "$?" -ne "1" ]]; then
 		info "Did not detect expected explicit drops: $?"
 		return 1
-- 
2.55.0

