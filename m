Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F4E3C3F5E;
	Mon, 21 Sep 2026 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985751; cv=none; b=NI5dNi1fioH9FGGarNUg7STtMutJGQLh5a1W/mKmpHYbBpqrUioeye6ZHyZSWDBZH/Nc7WXoluw1C9OQFH1fgD4V7zXq8KPWLK/HnxZtwjdYAZi3PGXibQ+rs/BGfXkwekajLj/5LO7qoValQQ6s5WKU2HEkhWYxfw6SyOIsVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985751; c=relaxed/simple;
	bh=TU93HLpvR1dP02TFve8ZQG/QDNfXb4wFD5OT8DFmE3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmYyBMehKJi/tfsKIU/MNOMNRFetRPSDlsDm1lZDw7m4L+ojj2yb8HqT6aLrZ5Piogr6w2sejIjr0SOxmWO5AkZXGbngMRl0rxn1KVTsSbx6gLS7YXnVseYCXg/L64o812Weyk2Iv72bzd8OW07kpxtPT4cCf6LgbRRLrLt6S8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NRuY5dBg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NRuY5dBg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=R58cUpihFiNJhRhiocI1VcD6CHdtizckpbaSpUo+PVg=;
	t=1789985749; x=1791195349; b=NRuY5dBgAkwmMRkDfQYLn55QMSSmUYlS0eo/+5h2ownqiqL
	zCSNffgOBUIPwabILCLSA5qWxWwbekSUKzdAJ3DNkaxeTrawwciP8+xoKG2cojICKr4QSDDx1m7iN
	j9UP6ch+7aJ524N8/UgI/ZF0S571TQ9Eo/l1a8OyOvf7w1KfKOmuFA9TN3Sc523RIPt6Y3qrY+6BP
	ieVQjAM+eWB87AwaEuYTm6zvf1dk+YBon5q3ENJGX29Re05y4Osszhtn529haJ4A4BTtliY7XI3FI
	H6laQk1RpG+u2FKhEENpoXDLCuE0ISGcmXCsP345FoLExGp1VrVY8fKhj4xh1mtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8b3o-00000005jvH-2LH3;
	Mon, 21 Sep 2026 12:15:44 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
Date: Mon, 21 Sep 2026 12:06:34 +0200
Message-ID: <20260921101538.97286-9-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921101538.97286-6-johannes@sipsolutions.net>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
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
 include/net/dropreason.h   |  5 +++++
 include/trace/events/skb.h | 13 +++---------
 net/core/skbuff.c          | 43 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 10 deletions(-)

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
index ab195b99c853..0c2d43797587 100644
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
-- 
2.55.0

