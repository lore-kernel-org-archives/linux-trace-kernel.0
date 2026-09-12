Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1ED429CC7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209589; cv=none; b=ercnme1Xc6rNof0WwnEzX292y+UkdEMfNx7YrrrVz2syCEl8rPFRyyMfEVyL3iBlTFv8wAPXYlqRAL5OIP56NAUvDiODSFDVaIhuMYDs0hmd1JyHtiRqhV/3joESmi1pPVeTc/9XSDnQRn+1tDOlUVFBBszNwrRh7YvyHF57nNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209589; c=relaxed/simple;
	bh=woTLYl0W/1NEs0vAl1EUBu9TVuDURQmng/NEGZELhK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMEY4m3fzeRgVRdBaLEgrZkLR/G2J/n1HoMCrrvv4Bcv4Lc1Jw6gSMpmATiD1yfPc713bLgzstmJzxBdIlOvard1vRyYC2Ef0nGNFwaDrGBVZZuXpm2RSA5+oYAAxUlp6yCOOsle8jgOtqfz4i6012MzqVdCaHEQXj13LQDrh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQlf6HB9; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQlf6HB9"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9c4c3e3b2so885469a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789209583; x=1789814383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W4i5WEIS0+RCnxCAmvMzbRWJ6LAh/sKzSDUzg0eVAWQ=;
        b=QQlf6HB9YLjOEizC+acH5G3M+oPFReMfkXdU/9qo+XmCWQvNzbSh5RHnq9so4ZLNSh
         4+Hvn4Eegce8H7m8nMer8ih5NFmIVljW2fLqPAWzGWjahHzqK0T1OYzeSdTMzrBgkMhT
         py5bZYhQ73eGYDWIb3GMVzg6wzxTxguSqi6HJKQxXsOcaT+zGMpbBVUcIZLFqstMp1k1
         m3wa9iwPXUMh2t6eZRUdOMSsME3jAEsQNHJe6avDSrJGFQP1/+G2PbZ7u/ngM4Imw7oy
         4LOt90iG+tjzO+ckiUrinXK37IPPTF7wS9lPEhhKQZJRR8FqgQINdc9iG4wDWQh8+E6g
         Yppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789209583; x=1789814383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4i5WEIS0+RCnxCAmvMzbRWJ6LAh/sKzSDUzg0eVAWQ=;
        b=FqpAkjfIprCQOg0GQkPvjaeL5k9k8YnIXGpIMh2y/YvwxV6m12rfBV+bNk6gtglWTW
         5f5AJzuEaR3nt6hzdja2x8eXFdb6JXa45wo5YOD1qQaNqEVvRVsk7Z8GSssTUgLlktjn
         i9CRWtNSUK1Tq2aY8Q3+qVpHPT5JZ9o/+BR2WQ8R/K37wyznksiOJ1y37U/DNkdeZb53
         Akmjr8ouQ/ljbp/1eb7W7Bu6c7vLuhDsRHig7srZwYuko2X1vos0WoLB+dpUy/jDyjBL
         EnVOwdta5HZDu0ZSfMUPjyO79io5+40ZVrqP1/07ettTtf7hbhhSpaRZkoipgzm21t1O
         7cnw==
X-Forwarded-Encrypted: i=1; AKwUvBxUWv/8AZ1vaAftKXLyVXNWtWl7boAKn0MUqKn3z79/0+51iCUcjaoSLzps4iR4xmeQfMAzOYUicRRm1xdSopRC3Xk=@vger.kernel.org
X-Gm-Message-State: AFuF++nuAsjteqay3SLLRYTLV/guLQzYrStJTplk5Bliu4pLDQfq/81U
	sJCUUAfVg5mAST+h2Rq8x9GNoC3VYNH0DKT1Lb580YNmMmVpOLCoUrfb
X-Gm-Gg: AYBFou2Nty5kf5fuMlzzxzgAIPo8rfI2wELSFhCVMXy+bislyYPdWs3N53VPB/nLxt4
	uRXtKkJmyUhjZRpj99qao//JvUDQFnltjcXUVxJ+22S11Rgehn7HA4G78bqrl8aWrCS3txirg8g
	SwT4lOG05SI5FYikpPpt9EvS/C+9/0SGqZ8WZQGhDmu9XUwOpOBPQSYByWPpJXFoJBZ597FVpJ4
	qIRGscB7DAlgRPkMO1cJKBcU8fjxMQOIpPy8975GDXne/zTAAGtWrgpAFeTulcl3VG/fI3SqzK/
	NoLs/B4bfBWRracBrOJ5R+hwJjxM7Xo6Jd5QhsfrAzrfw3uQvt7tBlDJb6j1JdjP+jHmzcmv7Bu
	t8o+ILXFbinVcNGxzJ6qv/aZ5dyUiuOlf6/UpMJOsjL2li7ihzBBtdp6B/4eW8ku6TXx6Y6H5tu
	0KK9R5BxL9xN7QOXFxj7d0I5La98eBuh5yAcWn3CR+R+wOqlBhnUfr+VxeMY1bmBmd4MSndLcWQ
	4aw+CaDWHlj9eHnwT+pcPrY+adzKUIBZD+KG+jfTi4vGs6Wz0wGhLoySTc=
X-Received: by 2002:a05:6402:1588:b0:6a9:93b9:f098 with SMTP id 4fb4d7f45d1cf-6a9b56a7951mr8237467a12.16.1789209583154;
        Sat, 12 Sep 2026 03:39:43 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b5831187sm1818923a12.1.2026.09.12.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:39:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ring-buffer: Check resize_disabled before publishing the new subbuf order
Date: Sat, 12 Sep 2026 11:39:38 +0100
Message-ID: <20260912103938.1127021-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ring_buffer_subbuf_order_set() stores the new order and only then walks
the CPUs, returning -EBUSY if any of them has resizing disabled. A user
mapped buffer has resizing disabled, and __rb_map_vma() reads
buffer->subbuf_order without buffer->mutex, so an mmap of an already
mapped CPU racing the failing order change sizes the mapping with the
new order and inserts pages past the sub-buffer into the VMA.

Check the CPUs before storing the new order.

Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/ring_buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..d7e5e4620d09 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7474,6 +7474,14 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 	old_capacity = rb_subbuf_capacity(buffer);
 
+	/* The mmap fast path reads subbuf_order without buffer->mutex. */
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+		if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
+			return -EBUSY;
+	}
+
 	atomic_inc(&buffer->record_disabled);
 
 	/* Make sure all commits have finished */
-- 
2.55.0

