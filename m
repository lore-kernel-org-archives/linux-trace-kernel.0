Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F5409275
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586802; cv=none; b=IzZE0unGeIqbFEIwinQ2GV84Jp2HwCQ/ytQOU3CWrDJrrXeGaNIRVUAnZfARZPH80uQlZ/mdZo2XbF8q0+5bePWGWELD5LnEvAO1OPeLQvgyAmjfjIBCZgh/U10LY1bZWKBUwewg54dLr36Xo7oTvYX9UutrTGhiXiwRUBUWZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586802; c=relaxed/simple;
	bh=D1h9fsMcvjsKv13n+F+quh0HDSXrCR58YnIKhayYq6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kehUDj0SMhnmnRgwwCmHXDkPQVdAsAi0ekvjXAc1onQYXjDuHAuR8aeFPWw7fEht9s25Q6eiAagg9cr0Et0yiGeSnamdGTjVlZN0CkpyyRUpcEZpmVML7+sxrFKRCRJ7hKlEbUIsYzw0Hq2+N9BXcETBYIqj64op/0mwO8jxSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7IXdfUI; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7IXdfUI"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99cd5115bso154395a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586793; x=1790191593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9TLJ0RsVpJxjU2Txsy2gxZGoZCHNVB1C035SNno+0KY=;
        b=T7IXdfUI7un8s+ZL1UnChTYNpTs9yZJZtGmOSrp12EZxRKl2TD86G86KI8xRJ/0t8I
         53Y2ewErheE+HA8WPn0unLymNt9AB51/NEhYwz/XJXJ43RBgyb9lrqzM0zjf3x4BZe03
         Kp23i7V04BO+pne4QFu5HiL3pjigTZRdqYOm5Mf25OMaQqWlV73/JnqmphY4wKnDCMVq
         u505X3pe1zJ9Qr3jruCMqW02tP+GpSt/tFXT0KFohodkrRN8XIug/nhVglwbchFKiSwC
         Wreaa6N6x/zbvlIteo2A1Tk9m/xGkbfstrWBdnx6XqIimAVFwIPoXE5p0A/iFsSECd7e
         amgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586793; x=1790191593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9TLJ0RsVpJxjU2Txsy2gxZGoZCHNVB1C035SNno+0KY=;
        b=ZFzPitQ1S2mIpwEQ0J2UDqinLgUVSRJE1B6pvci5wgSxcaEmBfKjIYm7SEf7w/yyMp
         XYoPg2slJJuaBwsWg1xV4ClrwPHSjrjMUtYGQ0VJoKE0WrjqowZEJW3THGp64IwpkX0y
         QvHgzOgz9JY1LgR/wGC5LmOHiT56Nkk9GAXZpsWvtuu00Xt4OBxuwKQ8H3dZLJeqfp+G
         xipwPRrCzTUt08T3jALHXFdBsY4O8wkC5l1ofc6fNv0gez/txKshwT3LSSg0ITfSwRad
         XZ2rKmft2LhzPa9piaieYsIj3IxwlsDkdVjfTCfI2C7Qx3pZenNrG7M96BB7rq0lR5m2
         ryfw==
X-Forwarded-Encrypted: i=1; AKwUvBy5kGHimWX1OwPS8Ps4k/sRzSANWpeQSuQ0VeGvDl/wCa6LBF0lTFvK6geJ58t1DFZUM3mYUH1Wc7T3eRpzvNJ6sdc=@vger.kernel.org
X-Gm-Message-State: AFuF++nqqC+ekPK7L/t+yZuzF8MV2UirFlzqahNBznvpgpTJfdJgosm5
	juuqFStOTSqVLDgjHwG5gRnQmElamvZlFb1Zkf9vfhB+8CujDKFxkO3zXcwzaQ==
X-Gm-Gg: AYBFou0FFFQ2j2kvUITQFO8fZkUZrCl1pTzxUk1wL5EEH/gvG9t3wmD6+cGCnlezac1
	ARtWocz3GSTI4VVr8Ygl1Q/NEkII1xkuMLdHfRSD5kv9KkAl+r4Y6qQ1S8rOnCE2fLl/gtibrf9
	8FBtIZs6MB5x7JvVnOO1uwLM/hKSTnuikcn8+KhjGBJOacLUmzNsTMdAYtCcU/Mnw3SwfX774TT
	BLSKkdmQ1HUMpMPnsJIHlUUa9NSe4MfzF57gAlY5O0WF+1pdfm+sbyyC1WfiWJt2dFTiGvAPKMN
	tXn98lgTRSrYKIbNJ4X73tWtfgA2diCQSLwQqWpEz05IXH++U8gD2WWuEqcHShUXKt2UOA8LaJy
	DtEGr0rmHQEPENam3fFUkpZJw/LNGbuglhPRwhBaf3Gu3cQlcuuUc16yq3rm7Ih/1JZV/JMLDA5
	pAAEJj0icAD4zojzfBmGhmvP56Y/1tiIcXcH8pdjtR96Stjyyoesqm61Q/Gf7kqG5vhLcVebnzU
	d+mKwj+YGTb/QX5cheNZddg7Xm7b1nef60AW9hvZMzeB9Hb6NuVCHYWX/s9
X-Received: by 2002:a05:6402:21d0:b0:6a3:691a:9d71 with SMTP id 4fb4d7f45d1cf-6aa22251052mr3001238a12.11.1789586792762;
        Wed, 16 Sep 2026 12:26:32 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d25e331sm2303248a12.17.2026.09.16.12.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:26:31 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: vdonnefort@google.com,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] ring-buffer: Take cpus_read_lock() when changing the subbuf order
Date: Wed, 16 Sep 2026 20:26:28 +0100
Message-ID: <20260916192628.274136-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914182850.21449-1-devnexen@gmail.com>
References: <20260914182850.21449-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU coming online for the first time gets its per CPU buffer allocated
by trace_rb_cpu_prepare(), which then adds it to buffer->cpumask. If that
happens while ring_buffer_subbuf_order_set() is running, the CPU shows up
after the allocation loop and the install loop walks it with an empty
new_pages list, corrupting the buffer.

Take cpus_read_lock() as ring_buffer_resize() does.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---

Notes:
    v2:
     - Reword the changelog: offlined CPUs stay in ->cpumask, so only a CPU
       coming online for the first time can appear mid-flight (Vincent)
     - Drop the comment above guard(cpus_read_lock)() (Vincent)
    
    v1: https://lore.kernel.org/linux-trace-kernel/20260914182850.21449-1-devnexen@gmail.com/

 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..e78fb4bb2195 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7464,6 +7464,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize > RB_WRITE_MASK + 1)
 		return -EINVAL;
 
+	guard(cpus_read_lock)();
+
 	/* prevent another thread from changing buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
-- 
2.55.0

