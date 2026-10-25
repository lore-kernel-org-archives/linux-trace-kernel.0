Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792891159;
	b=mYoPO7piYgzblQ0lvvrZMZH9jWCDK4lMn97oelz3k8GTVBJCCrYWa/F55Um4HQOwbXs/
	 +SGx/P+IFYdV8LOvJefagzPaJWTZlkT6TZuCYtq48py98S6F4L0J6xfc2LYCFABAM36Fs
	 V1vHhQZ3z9kiOi5X2uaoKll6VMd/HeMR9rwHubehEGxqFPpXJgmrIQaVJYFjQbZFuWhTW
	 KVvbB1vL1HR5zg2JczyGrl5y76z9vyBWAXHmYGWQ13YyOa/XXBwoWfLjR+5PNPCKVohTH
	 8l+LPLFM9gAhgz1/K/4hqFw1K7fGdB++SA4fEz7qq0cZ/2fie0MGpqUR7CgYy2lIjLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792891159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
	b=sE2gsi6Jsw89XGcf/r3VQNXrNVUZop6FafnGSzoky2o9yAZM7ONu0aWyGZvvNbQwmAOA
	 fQ63BvesZySiqljM57jJ67FcfOLA6+vLibr0sTvdtU3vssBlkolYv0EBF1aj76/+0uTK+
	 lcsbtKqGNWPFldMWUmc/kvgg+wuupMecP8qOjkkL9Kzdk4kQ4I7RUarbI767rrCoXE6Il
	 7X+ZV6gVGqdfrTB63ztWOvtLszBlxJ0P1CEJ11wCs2jCCitJfWUHZJKDBXen4yfHsCi4m
	 58EDGNuvGF8C3+KHCWHUwCTmo3T7MH76BXlcHgOMVt0PD6hwusb2dOYVO4XHUd351bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nyUFwVcj;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8386606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 01:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8386606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nyUFwVcj
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so1422230a91.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 18:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792891158; x=1793495958; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
        b=nyUFwVcjgd6g3xuNlSD/rMAoH+5rhnVhKVDNLCsK4WeHGC6W0qiL1ts8cv2tR1rrUV
         25HBD5SR+xxXKkJEZAgiBcwUwzFB/8BmOaZyQfXgksIEQPAA7hzt77jyYLP8tiOFUItI
         W9iZBfz9LCduMPMN5NGg4KhetNlKWFha5VYkZea131wCfXvhV3PdR6ebjUC9EoVAVyn2
         AH/Evm6Z7YrF7QQ6sOLK36AH4Sy4N30imPWThuGRMJQXCQD/m6QVbiS8UFrPoTvwbgoy
         C5oM7nXa3UKdOZ8ZAuZnhUnSXyuO1smqDpTLCqvs//S/k1X8Fb5g6Tk/wRdQk1gvuJ9F
         qGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792891158; x=1793495958;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZQiqU7HN1B6GTDcBYXT/sQqb91Q6ayBvJSvSKkioZE=;
        b=LW8S1DELvE6DhFeQSCgxzZW9XTj/6hodUBa/vWkt+np9362MRuPnzeCV1HeAqCpE3Z
         stAoecY+9sfHbzPpHsI8KAx8sjIl4xslZDiCazmgOIbzCDLrdfA8O+amdKcKNesiHP3q
         XLKdLqPJMtQrvi2p3Nr9JkuUXBkGO9q1NBPG4CU7K5Vp/DdProBbYbTq247wyt5FdCVX
         zTOPjzoc8L5TE6u+9UhhYG+/eyAnRldWXQ8tHzjmIK3Mbg+W6Alh7FIUhtkTuj23Kofm
         IIUDeZqoZ19+JpgSRH/0C2vugaYPxB9Zx3+NmV68oHvsNxskeAEjwbAzLAiitHjMi0Ww
         v/9A==
X-Forwarded-Encrypted: i=1; AKwUvBwiEjHPQPfycSo5tTyoDIgnXtvZ9ZgKkVDwOPhydm1iJRL4A5SxL1YUcQ3pNsT8zn0VxQjTeLOYN+HIvdmso3ydhRo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNhqm+0FBWs6Hu1hRu9IWSTMl4H6I9MBRvpsEbqgEyuqpGOgyh
	NHxCM9dJ+HvlqxRWkrkjkpr1S452e0KSO80qmmHKPl8Qn/6+pReVdJZe
X-Gm-Gg: AYBFou1xdYWinS7Q20AyMu5GaVYGQXmZ4Yl33YJok5ao3vHc4bzu1mckR7IJ3yAsgwN
	QVX7rdwQhDUOPwHh6MUFh4qF2mgoRktkqukihrytilLDrTdUm1yk1831YaeRAXKwpKOrKr0qhmZ
	7GsvcmkpThteoyELZ5zCJSE8yyMOYuWPnyquFax4B7W8iwjGwKsoRZoLOdgI44nUIe3Ylo3qXQ2
	2ceDxzEFLwpUPY6bQMCGzkaWWDxR7fbAcxv2fOS9MDwlhg5e9OdOhc1pMYbsCu+FacnkMhYisFg
	eqyRS9n9TWKDDVKEKmDyvUNMSLjbqEVyLS0e049XWsiubex+3GrRKT5QcLDXmQyfgIrYoK7lhHY
	JVVgOq/5DEchIFP1ftHl/NsPkR1u0KidlUOzadGNu2ZCGzg6v5fDytNf6AGUi6PMvy8r8r9ghXK
	YHLM6HsfeRz48wOcRAzwEafbimw3BS5arwZo/omOLCCKQYIHBtS9VZ1FcVJVfOkAwTnViDdFkQV
	ZxBw7K29NAjB3rToj4brtOQPb0FWdSbjk6N/oQYw0oxcedndm5IZu4Qdf4aK0oGf2+V5jch1ULz
	SCG6Ee5Nzrn5arBSG6JOeY/rGIE55N4fuanm2TnwNZp1zhaiXntuV1VwUhR4
X-Received: by 2002:a17:90b:1a92:b0:3a0:bbd8:5ba7 with SMTP id 98e67ed59e1d1-3adeafd7770mr2867415a91.62.1792891158057;
        Sat, 24 Oct 2026 18:19:18 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32f70sm3963081a91.1.2026.10.24.18.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 18:19:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 01:19:16 +0000
Message-Id: <DMDIVEW7P9QN.1TB58XDPD7V3A@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Shuah Khan" <shuah@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Hangbin Liu"
 <liuhangbin@gmail.com>, "Martin Karsten" <mkarsten@uwaterloo.ca>, "Masashi
 Honma" <masashi.honma@gmail.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add syscall common attrs support
 for xdp link_create
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261024153608.58569-3-leon.hwang@linux.dev>
References: <20261024153608.58569-1-leon.hwang@linux.dev> <20261024153608.58569-3-leon.hwang@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 24, 2026 at 08:36 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> Instead of passing bpf log or extack to bpf_xdp_link_attach(), pass an
> errmsg pointer to receive the kstrdup() error msg, because

[...]

> 2) passing extack will access underlying driver string out of dev_put()
>    guard, which will crash kernel when the device is unloaded
>    concurrently.

Netlink does exactly that.
rtnl_setlink() looks up the dev with __dev_get_by_index(), so no refcnt,
do_setlink() -> dev_change_xdp_fd(dev, extack, ...) calls into the same
drivers that set the same strings, rtnl is unlocked, and only then
netlink_rcv_skb() -> netlink_ack() does strlen(extack->_msg).
All extack users work this way. kstrdup() in one of them fixes nothing.

Instead of patches 1 and 2:

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c0ae442..6f7fec2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4440,7 +4440,8 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 				    struct netdev_queue *txq, int *ret);

-int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			struct netlink_ext_ack *extack);
 u8 dev_xdp_prog_count(struct net_device *dev);
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 90bc723..0ce75ee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5862,8 +5862,12 @@ err_put:
 }

 #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd
-static int link_create(union bpf_attr *attr, bpfptr_t uattr)
+static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
+		       bpfptr_t uattr_common, u32 size_common)
 {
+	struct netlink_ext_ack extack = {};
+	struct bpf_verifier_log *log;
+	struct bpf_log_attr attr_log;
 	struct bpf_prog *prog;
 	int ret;

@@ -5873,14 +5877,24 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (attr->link_create.attach_type == BPF_STRUCT_OPS)
 		return bpf_struct_ops_link_create(attr);

+	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
+	if (IS_ERR(log))
+		return PTR_ERR(log);
+
 	prog = bpf_prog_get(attr->link_create.prog_fd);
-	if (IS_ERR(prog))
-		return PTR_ERR(prog);
+	if (IS_ERR(prog)) {
+		bpf_log(log, "Invalid prog_fd.\n");
+		ret = PTR_ERR(prog);
+		prog = NULL;
+		goto out;
+	}

 	ret = bpf_prog_attach_check_attach_type(prog,
 						attr->link_create.attach_type);
-	if (ret)
+	if (ret) {
+		bpf_log(log, "Invalid attach_type.\n");
 		goto out;
+	}

 	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SKB:
@@ -5931,7 +5945,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		break;
 #ifdef CONFIG_NET
 	case BPF_PROG_TYPE_XDP:
-		ret = bpf_xdp_link_attach(attr, prog);
+		ret = bpf_xdp_link_attach(attr, prog, &extack);
 		break;
 	case BPF_PROG_TYPE_SCHED_CLS:
 		if (attr->link_create.attach_type == BPF_TCX_INGRESS ||
@@ -5959,12 +5973,22 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			ret = bpf_uprobe_multi_link_attach(attr, prog);
 		break;
 	default:
+		bpf_log(log, "Invalid prog type.\n");
 		ret = -EINVAL;
 	}

 out:
-	if (ret < 0)
-		bpf_prog_put(prog);
+	if (ret < 0) {
+		int err;
+
+		if (extack._msg)
+			bpf_log(log, "%s\n", extack._msg);
+		err = bpf_log_attr_finalize(&attr_log, log);
+		ret = err ? err : ret;
+		if (prog)
+			bpf_prog_put(prog);
+	}
+	kfree(log);
 	return ret;
 }

@@ -6536,7 +6560,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 		err = bpf_map_do_batch(&attr, uattr.user, BPF_MAP_DELETE_BATCH);
 		break;
 	case BPF_LINK_CREATE:
-		err = link_create(&attr, uattr);
+		err = link_create(&attr, uattr, &attr_common, uattr_common, size_common);
 		break;
 	case BPF_LINK_UPDATE:
 		err = link_update(&attr);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e78..4aa5525 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10882,11 +10882,11 @@ static const struct bpf_link_ops bpf_xdp_link_lops = {
 	.update_prog = bpf_xdp_link_update,
 };

-int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
+			struct netlink_ext_ack *extack)
 {
 	struct net *net = current->nsproxy->net_ns;
 	struct bpf_link_primer link_primer;
-	struct netlink_ext_ack extack = {};
 	struct bpf_xdp_link *link;
 	struct net_device *dev;
 	int err, fd;
@@ -10895,6 +10895,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	dev = dev_get_by_index(net, attr->link_create.target_ifindex);
 	if (!dev) {
 		rtnl_unlock();
+		NL_SET_ERR_MSG(extack, "Invalid target_ifindex.");
 		return -EINVAL;
 	}

@@ -10916,14 +10917,14 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	}

 	netdev_lock_ops(dev);
-	err = dev_xdp_attach_link(dev, &extack, link);
+	err = dev_xdp_attach_link(dev, extack, link);
 	netdev_unlock_ops(dev);
 	rtnl_unlock();

 	if (err) {
 		link->dev = NULL;
 		bpf_link_cleanup(&link_primer);
-		trace_bpf_xdp_link_attach_failed(extack._msg);
+		trace_bpf_xdp_link_attach_failed(extack->_msg);
 		goto out_put_dev;
 	}

I'm think I gave this suggestion earlier. Why did you go with strdup()?

pw-bot: cr
