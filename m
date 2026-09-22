Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264D539790;
	Tue, 22 Sep 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075412; cv=none; b=DL+EIaM5XYDpjkR39JU2XpgGv6HfTCaKGzrX8+POrgsDMVx70bDLHDkSMtCd3AIoNpAT9ASY6aWu+XaBT5+mSmhYY3Tfn9ihwbANGHmuHcPicfzAp94tQyoR+XDH9NvZ4DNbqN6HRWG+MRBQWCp5Vs+gA4w63cXUE8PbVhbRtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075412; c=relaxed/simple;
	bh=gEMS3jWqMG+zrAYTQfEyWwP8W1cn3KnjMjRQEkuaZxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCVMSDo8p9WUSxgyKdAJCOxiklpNt9DbS6X7Cj6csiHGCtliVDGPF4dohGmI4y2jF8ALTKaUF8IpJy636zUh4iHW3yFnTFA8ThjbvzMvHbSXN5RsqqyKiYln9Q7goaeIZXrJNKcNG1WChM40oW+C047T3H7nxUHGWvePEJ7VlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PCV+V2bD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PCV+V2bD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8PaboYWla8SkdWZNCuEDUE3IfbM43aIIHI27y/D6iQ0=;
	t=1790075409; x=1791285009; b=PCV+V2bDdEL8UUeD5lal6rdjRVwHjBcDpAH8ygca21jyG9N
	Jib+5xq+LH1DK5yJYr9GgOPMSy0F3hKpg9NEOW2fS/J3lPRRbwR7CDBKrwpXiKz2DyOePWcB4DhRy
	unb9FCCoqKD3D+gaXQPUm+Urrh15+uGINKsFFk9egJ1+5hSs8wce0cfu5uk/wQWYTKLAn6EKYiRt3
	/yOtsmfqpbUq27dCTWPwW3UKWAF70Wdpa4zdU3KSzxRyp0adtrplzaXVav0mesC5iC5OxOmYN4Jds
	U70drUXTNmJ8l/6RXCvKvIWsgCpCl4A8Jf+vMXHk+7lOvWxpzR23a/cE+wLU+oiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8yNw-00000006qo8-3dtU;
	Tue, 22 Sep 2026 13:10:05 +0200
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
Subject: [PATCH v7 4/4] net: drop_monitor: use drop_reason_lookup()
Date: Tue, 22 Sep 2026 13:08:43 +0200
Message-ID: <20260922110955.363677-10-johannes@sipsolutions.net>
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

Now that we have drop_reason_lookup(), we can just use it for
drop_monitor as well, rather than exporting the list itself.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v7: don't hide drop_reason_show() prototype (sashiko,
    but it got it the wrong way around)
---
 include/net/dropreason.h |  5 +----
 net/core/drop_monitor.c  | 20 +++++---------------
 net/core/skbuff.c        |  6 +++---
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index dc4a60130c09..537428c72642 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -38,12 +38,9 @@ struct drop_reason_list {
 	size_t n_reasons;
 };
 
-/* Note: due to dynamic registrations, access must be under RCU */
-extern const struct drop_reason_list __rcu *
-drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
+const char *drop_reason_lookup(unsigned long long value);
 
 #ifdef CONFIG_TRACEPOINTS
-const char *drop_reason_lookup(unsigned long long value);
 void drop_reason_show(struct seq_file *m);
 #endif
 
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index edc660778408..5aa7692c5df2 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -611,9 +611,8 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 				     size_t payload_len)
 {
 	struct net_dm_skb_cb *cb = NET_DM_SKB_CB(skb);
-	const struct drop_reason_list *list = NULL;
-	unsigned int subsys, subsys_reason;
 	char buf[NET_DM_MAX_SYMBOL_LEN];
+	const char *reason_str;
 	struct nlattr *attr;
 	void *hdr;
 	int rc;
@@ -631,19 +630,10 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
 		goto nla_put_failure;
 
 	rcu_read_lock();
-	subsys = u32_get_bits(cb->reason, SKB_DROP_REASON_SUBSYS_MASK);
-	if (subsys < SKB_DROP_REASON_SUBSYS_NUM)
-		list = rcu_dereference(drop_reasons_by_subsys[subsys]);
-	subsys_reason = cb->reason & ~SKB_DROP_REASON_SUBSYS_MASK;
-	if (!list ||
-	    subsys_reason >= list->n_reasons ||
-	    !list->reasons[subsys_reason] ||
-	    strlen(list->reasons[subsys_reason]) > NET_DM_MAX_REASON_LEN) {
-		list = rcu_dereference(drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_CORE]);
-		subsys_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-	}
-	if (nla_put_string(msg, NET_DM_ATTR_REASON,
-			   list->reasons[subsys_reason])) {
+	reason_str = drop_reason_lookup(cb->reason);
+	if (unlikely(!reason_str))
+		reason_str = drop_reason_lookup(SKB_DROP_REASON_NOT_SPECIFIED);
+	if (nla_put_string(msg, NET_DM_ATTR_REASON, reason_str)) {
 		rcu_read_unlock();
 		goto nla_put_failure;
 	}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8c8f7a05dea4..c675d3330937 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -148,13 +148,11 @@ static const struct drop_reason_list drop_reasons_core = {
 	.n_reasons = ARRAY_SIZE(drop_reasons),
 };
 
-const struct drop_reason_list __rcu *
+static const struct drop_reason_list __rcu *
 drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM] = {
 	[SKB_DROP_REASON_SUBSYS_CORE] = RCU_INITIALIZER(&drop_reasons_core),
 };
-EXPORT_SYMBOL(drop_reasons_by_subsys);
 
-#ifdef CONFIG_TRACEPOINTS
 const char *drop_reason_lookup(unsigned long long value)
 {
 	unsigned long long subsys_id = value >> SKB_DROP_REASON_SUBSYS_SHIFT;
@@ -171,7 +169,9 @@ const char *drop_reason_lookup(unsigned long long value)
 		return NULL;
 	return subsys->reasons[reason];
 }
+EXPORT_SYMBOL(drop_reason_lookup);
 
+#ifdef CONFIG_TRACEPOINTS
 void drop_reason_show(struct seq_file *m)
 {
 	u32 subsys_id;
-- 
2.55.0

