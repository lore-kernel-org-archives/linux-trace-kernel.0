Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D541DE4F6
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902936; cv=none; b=PZmhny0tjjUe0l3z59td7o27ngAzDgoZupatbUxTItsmteSq1hDR2DYAsf/uLhzqjpTaXIrhGfVoc+1YFQL7mrszcxYlnLETfHGCLBpWvCM5fTQl1jx/8f/QbshnmCziZiCj2Ny5aGr1VhEIny00s+DP9iPyReDzLNlUyRrI7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902936; c=relaxed/simple;
	bh=ugVudOCH1QUE1lgwU5uFhMmaWqGYLvdAJPoGrIVsNCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGwmMT3T8cRD6LqUawGh/MRQIH3bOoeUoiCwkNYnA0vHFO3YXcIBFkcGh4CS/EEe2TGlg+EV1pbLTReZJUS3paO0++vEiWuBSTu/+/HC8fYohgII5lv9JqMPpVTEoebHg6fbH720HPdBpbSBTFP5/V6LVqJYSDLSMgqqPZP/n0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZbREFHhr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZbREFHhr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751902932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMHqMHAxGD1r4fmMDbndGO/4sTwGSp8V807ueJrjmno=;
	b=ZbREFHhrpkqPz5ufEJ3r8iCI4F5m3Y3LBHfZVE6dnnKBVBdaW9qtEZbR8Kh5mMztKbWyA/
	Nhn7gqSlZ38NrFbGXZiAUEUMCEoZIVGwelWLFHrKi1F5yFYasIkU0Dg7achKngBC8zOzVE
	hil14RyrtW3P5AjsREoEBnXA20zRytQ=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 3/6] bpf: Remove attach_type in bpf_sockmap_link
Date: Mon,  7 Jul 2025 23:39:13 +0800
Message-ID: <20250707153916.802802-4-chen.dylane@linux.dev>
In-Reply-To: <20250707153916.802802-1-chen.dylane@linux.dev>
References: <20250707153916.802802-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use attach_type in bpf_link, and remove it in bpf_sockmap_link.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 net/core/sock_map.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index fbe9a33ddf1..5947b38e4f8 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1709,7 +1709,6 @@ EXPORT_SYMBOL_GPL(sock_map_close);
 struct sockmap_link {
 	struct bpf_link link;
 	struct bpf_map *map;
-	enum bpf_attach_type attach_type;
 };
 
 static void sock_map_link_release(struct bpf_link *link)
@@ -1721,7 +1720,7 @@ static void sock_map_link_release(struct bpf_link *link)
 		goto out;
 
 	WARN_ON_ONCE(sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
-					  sockmap_link->attach_type));
+					  link->attach_type));
 
 	bpf_map_put_with_uref(sockmap_link->map);
 	sockmap_link->map = NULL;
@@ -1772,7 +1771,7 @@ static int sock_map_link_update_prog(struct bpf_link *link,
 	}
 
 	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
-					sockmap_link->attach_type);
+					link->attach_type);
 	if (ret)
 		goto out;
 
@@ -1817,7 +1816,7 @@ static int sock_map_link_fill_info(const struct bpf_link *link,
 	u32 map_id = sock_map_link_get_map_id(sockmap_link);
 
 	info->sockmap.map_id = map_id;
-	info->sockmap.attach_type = sockmap_link->attach_type;
+	info->sockmap.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -1828,7 +1827,7 @@ static void sock_map_link_show_fdinfo(const struct bpf_link *link,
 	u32 map_id = sock_map_link_get_map_id(sockmap_link);
 
 	seq_printf(seq, "map_id:\t%u\n", map_id);
-	seq_printf(seq, "attach_type:\t%u\n", sockmap_link->attach_type);
+	seq_printf(seq, "attach_type:\t%u\n", link->attach_type);
 }
 
 static const struct bpf_link_ops sock_map_link_ops = {
@@ -1869,7 +1868,6 @@ int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_map_link_ops, prog,
 		      attach_type);
 	sockmap_link->map = map;
-	sockmap_link->attach_type = attach_type;
 
 	ret = bpf_link_prime(&sockmap_link->link, &link_primer);
 	if (ret) {
-- 
2.48.1

