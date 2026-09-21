Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614D3E0C4C;
	Mon, 21 Sep 2026 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985752; cv=none; b=Zq3Jaj82s3f8SFu8osYQ/QojKPFE34JIgSTi9WsWEYd7DKA1QDcKsCS1KAwoBQz0nSIX1eEOf1ckKUJ9Y+NiiQyLI9Ur2gDp2JtDuZ3HtdteDblAM08GvI9xN15q3nrGq90Cv6nvOxQg2558KuP6323YWGs70UJgxkRpk1sd4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985752; c=relaxed/simple;
	bh=qRbo3nIagDmOVXamtI/Wqt7gq1MvSeelgCrdL3Y69hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPmB7FZX+wju1DUESU4cQR7Je9+upVKWCyIIBwBW5wlhCv31AX3E28rPkGevZAbYaJc4WYi+qJflDKEsbN7kgrGB5nMfG6l1U1rl/Jc6XnuQ9nissOXy57JOpZT9Q+a2xCM7wJC4JqTBOCBk6DOhtShjRlrA7jpesHkSJxrbMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AHlhXWB9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AHlhXWB9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EDn54jabC0To4na0WfUtOppzSuDggojBsbVFmCKJPl8=;
	t=1789985749; x=1791195349; b=AHlhXWB9zIZ28q7r9fz6fEEUj4I3ckc1lszH9zxppcILuZP
	vvYdq0FfBCdCk3Cu7DGvhUDOE5Ct4qlR1+iaGO+5IEyQFdKfoIbqgw16/VS9+5VtWJqFFDSYpW+8S
	zq+ZFK0gLHLWwyiHt9YvfztAfTA3eHTGjqsutnp7YRvRym9q5pNmtoFDIXBrX/aIE5sLYAEHjoYxm
	toaibPkntMlm5h2wPlp8zfO8Wy3C27EWS2JW/pvCY55iu40BSi07jgK1zWiasBMblZpGceEliw0tn
	1xqdrjlXiAbB40GMslWMXPnLOcJUEEjrFnZg7N4kI/T82ZfEtiVwqSzBmoH6pilg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8b3p-00000005jvH-1jqe;
	Mon, 21 Sep 2026 12:15:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v6 4/4] net: drop_monitor: use drop_reason_lookup()
Date: Mon, 21 Sep 2026 12:06:35 +0200
Message-ID: <20260921101538.97286-10-johannes@sipsolutions.net>
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

Now that we have drop_reason_lookup(), we can just use it for
drop_monitor as well, rather than exporting the list itself.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/dropreason.h |  4 ----
 net/core/drop_monitor.c  | 20 +++++---------------
 net/core/skbuff.c        |  6 +++---
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/include/net/dropreason.h b/include/net/dropreason.h
index dc4a60130c09..4680da5964ef 100644
--- a/include/net/dropreason.h
+++ b/include/net/dropreason.h
@@ -38,10 +38,6 @@ struct drop_reason_list {
 	size_t n_reasons;
 };
 
-/* Note: due to dynamic registrations, access must be under RCU */
-extern const struct drop_reason_list __rcu *
-drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS_NUM];
-
 #ifdef CONFIG_TRACEPOINTS
 const char *drop_reason_lookup(unsigned long long value);
 void drop_reason_show(struct seq_file *m);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index abaf108ac4db..5b685f918cc2 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -612,9 +612,8 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
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
@@ -632,19 +631,10 @@ static int net_dm_packet_report_fill(struct sk_buff *msg, struct sk_buff *skb,
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
index 0c2d43797587..d74022457893 100644
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

