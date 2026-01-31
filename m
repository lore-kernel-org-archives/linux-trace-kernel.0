Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA03352953
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866167; cv=none; b=LCgsu0h01LQS/IW2yUb3+srlU5Xp4W7iGoFuXsVJCj4G4n8G+9P6kTLJ1budVX/CM+tmyo3aA7h9dvEMWzkXeMD+udNUzdUcvfJaa0Eulkt1aW7ceAlR+M7GuOvzoIcpkIM/NBizA6xNXcA3uyVd5RY9rcoBXx+PTl0CPsjKxbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866167; c=relaxed/simple;
	bh=RJWjeYAvcYE0G2q2xGvAOWGYBGJxgtvgmHt6tSOKAYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ma6KXCVXI32CVZTh0N6UCDb7NXvAM6JyRnZl9ALlWzBHoXgXO6LQ4m4pvpQrlYIG5uA49owiSzjhnKOKONWhfNAM55kUnhlaVCK0iGBJIWKIbJeF4rMoVE9o2OZgYHWgYMDpbg2LRfzIKfnzPX5xII4nNo1w6ADTUTnw/0vz1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Itq+b8Ok; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Itq+b8Ok"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-65811f8a102so2920937a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866164; x=1770470964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tUISk/ccjHYHokYv6vg+0xvhja6CQE9jzscbfeu7VUc=;
        b=Itq+b8OkgBDmX4w1RJ5N22lxG7iRpMUxDB1kVi7c14ph7GETeea5pxiP8DHfZ0NHOn
         7fr4msWLy4D3TLu3JwNfw7JagCLo8fExidAZ071CXDxPuAyVT2N0wSDfr6G56erMgzPx
         LLcFHqC8mUujlUY6Fd2e8rRYeIel3nrflx9KnN7UxxC+cA5Lw9Wp90yvTxn2uoDBgKIr
         2PnaAJ6/GQqKhnzwElf+zWXu56RMsJ8Qt/zS/aFAMNsTXiQdVDiziBgiVYiLsEHtus2z
         oxfTrweBfk8TZptYQNTHjclmDbJOVLdwrPOIQLYthFJqUz2Sx/XT+Awizz7bV3COfb4l
         49wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866164; x=1770470964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUISk/ccjHYHokYv6vg+0xvhja6CQE9jzscbfeu7VUc=;
        b=SJp9UMFp2N/J46D8uljeqsLZwvLTq164AYEhLbtVXKpB6OgriKCfHAFkSbrnEC4Oqj
         gkdfGe6rMSx2o9kQDJ4DXsa0fvYAriiEFbrlbB6pc0L+Z/Bg1Wy3TyakPQelsc+dlmgf
         C6xKkF4dTPrT1zcsCb39DiNWRpC0JITQbubNI0kCspxH7H7SMn7RAXd8O77jQlaGmJRe
         /dlRbc8Te9VvcpQhEeCxOTHK/LEdk5nCp1Do22T8Kk3QRTvIYsnsEc6Him0iW1mmvyaB
         MuKtBrxPI8onHl7dkZTRX97ZjQmlRdx/+aIzmIHFsp72SaM3PX9uaQAYn0oJhhPHTsKj
         jsuA==
X-Forwarded-Encrypted: i=1; AJvYcCXD7i2SsLCmdFgqMxWYRW0HUq4DRsjNh+eGe6q1iPiUbh6XUYp57hD38g/7szt9c/5MrhlxInS62GWzfInf/rSz08c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK45K24j2Iwaz/QkvKIJJv7BqHa93ZEKk/6HFXwSSIvqa/mTt2
	19Yc6kC2gDSzkc+2MDS0cSfs8Zk4Nz7WaSsaRLXdRUBTjp2lkkKVgsIPLgqHKb8WY8ifJ6RewKO
	zOrSll7W0g26etFMk2cuwNA==
X-Received: from edad40.prod.google.com ([2002:a05:6402:4028:b0:658:817:e783])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2711:b0:658:11c5:2f96 with SMTP id 4fb4d7f45d1cf-658de5a9a0bmr3448451a12.25.1769866163834;
 Sat, 31 Jan 2026 05:29:23 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:20 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-3-vdonnefort@google.com>
Subject: [PATCH v11 02/30] ring-buffer: Store bpage pointers into subbuf_ids
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The subbuf_ids field allows to point to a specific page from the
ring-buffer based on its ID. As a preparation or the upcoming
ring-buffer remote support, point this array to the buffer_page instead
of the buffer_data_page.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1187d632dd5d..a5d11487337e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -554,7 +554,7 @@ struct ring_buffer_per_cpu {
 	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
-	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_cpu_meta	*ring_meta;
 
@@ -7013,7 +7013,7 @@ static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
-				   unsigned long *subbuf_ids)
+				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
@@ -7022,7 +7022,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	int id = 0;
 
 	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
-	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_ids[id++] = cpu_buffer->reader_page;
 	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
@@ -7032,7 +7032,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 		if (WARN_ON(id >= nr_subbufs))
 			break;
 
-		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf_ids[id] = subbuf;
 
 		rb_inc_page(&subbuf);
 		id++;
@@ -7041,7 +7041,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(cnt != nr_subbufs);
 
-	/* install subbuf ID to kern VA translation */
+	/* install subbuf ID to bpage translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
 	meta->meta_struct_len = sizeof(*meta);
@@ -7197,13 +7197,15 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
+		struct buffer_page *subbuf;
 		struct page *page;
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs))
 			return -EINVAL;
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		subbuf = cpu_buffer->subbuf_ids[s];
+		page = virt_to_page((void *)subbuf->page);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7230,7 +7232,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags, *subbuf_ids;
+	struct buffer_page **subbuf_ids;
+	unsigned long flags;
 	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -7254,7 +7257,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (err)
 		return err;
 
-	/* subbuf_ids include the reader while nr_pages does not */
+	/* subbuf_ids includes the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-- 
2.53.0.rc1.225.gd81095ad13-goog

