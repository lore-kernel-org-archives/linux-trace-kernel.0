Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D726A1AC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935441; cv=none; b=e7BFbiTqquZDocbxTN9zDKvbjBfb4lKC1s9MsTOjEzrD9bBoI766wloaNTg2M2LSb4Vo2D4PQE1GLlsgHqEZZEQR73gWJxpSfxa5g21bweee8gJ1OBdBYoL4JIaAP144qXntR0bUOOKntY9BLAay5va63JkZS2SMRlKwTbmBUFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935441; c=relaxed/simple;
	bh=TbvdMU5uBRwk78kw9thSCvNvr4Qo+KDKUggC7rePmx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DRVWbMdgDmvz222v8X5PR1oaZrC5ZMJN045av9tmN9evUyuQj6Py0HiJ96/v155Qn3l2lhCd9J19U61UuaUWcNKGhelTXx0o8VpyIvh091FFW/iE3bzasVooshTTBt5Yik5KwXZhQk6c+NCl93VanCplyP366dvQkx3k4B81UW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEdYQeKO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEdYQeKO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482ea739de2so3735591f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788935438; x=1789540238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oWVSfJYhAn6e2RRpwRhzeBGFUz50IiA+3fKcwx4qg9M=;
        b=MEdYQeKOgiP8FUwSk1uE6xe4E6ThKnBqsC+0BKoi59ZVWG7xuyC4OVHUdqLIrC0LGk
         SihcSvqN851j4K3exSigNIuRIKNB5avu/JLzMGTXppGpnKMYhV18RnZTvdOGRpUP55XB
         6Ve+XetMcXZnnla1XttT3TTXYFuogrR+A7f4SFL+8HsQgyMWozKqU0oe7pCCLQsX5LMe
         wqxUa5FjrE+17wl7MfZs29A+RvOl1dZrIMi1FaV8AOk4w/9UlyqU6Fr+mvkTEy/Rvefb
         XZ5KePngDG965WhEFJdgjVCU9bhfAuzTNmfM09S1UNxKF503hLxpUR8n8d7WSZTYHngd
         5QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788935438; x=1789540238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oWVSfJYhAn6e2RRpwRhzeBGFUz50IiA+3fKcwx4qg9M=;
        b=NxG7Kp70lps4q/RlZ29ZgaArIOVXTDK/D851m7pHGICPNZtDDe+HkY/XGhdY8uaPFj
         OTSW/Wvz+8IUfPR0TK8ydYyUsEZ5z7VGC0b27qj98mCEfRDW6uh+A6SAeJhA6qbVyIgY
         xRgE1T9egppKGQytOceOuynyw2JpEucs8Tv5Sti6IcHSWheX7fRORmqtLRlWI3PDUGy/
         aa5OJKVCPe7oxWRd6ijQnJsJvmR+gMeUs3kk8uury+LMSDg6fH0tLgUPuzwaOrjQfdTE
         7MjY0llIhEWtzOUQJV4xu8SvtFUYWOfJCdRC+GlLAp/22WqLFPVlTATAlYjhAfyJPN7O
         j4tg==
X-Forwarded-Encrypted: i=1; AKwUvBydLKbUOEErxOEvYzsaePZTZye2Thjnb/VNQ0zhAwIvsAJIejbYoMRzd9YcKtKG3BT3wqmLYKCDyt+pZE3udOUe0TI=@vger.kernel.org
X-Gm-Message-State: AFuF++kFKUGmt1sC1yoPgjLmQVBnUGa2+ylBmM+MiO3qRx3x/DJoSfSO
	HbdGzhnwD2dkZtQGbiRVOvFUuipNO6uqqadk3dQU9+/VWnyIzyGCDh3l
X-Gm-Gg: AYBFou1IAVFMois4cCrYb+xrVXOVbBj2hyF4zg30PMlv3sANmY/oEmsy12W6j67NC03
	jYbApGehpHrQhSXwmuk+s/4aaF8D3eDRE9Ta1NUdHQbti+1QYF1CkBhWlPKu/91x9aq8WegXwiO
	9bTJsiNHHoNDHd7X1k5n6RixnFq/Tz2fuZIvb978eDlfBZnxFvrcCk+szP0GZ0E61X01VKaojmu
	w0mB2LVK3jFJmusEsSa3QKoEOzeIJZzh/JYfC9VP6zPQLiMUK6kvq9ZnzTJpZyj/HAy/xvFYonP
	gb04UAsX87CBJUrueiuRVj1s9vIxLmPUeZxmneOQJ3Du0n7fAEywQKlYdxWW0fr5qxWpB5WfO40
	TayjSYcJxD/kEPQpkH83iUuvqf7Kz5IjBBwUV+K6D1ssDJ4J0QHsx/FhHZ3rO4Gn/01+YBFTomw
	1tHenRAODQG3srJuBf09JEBky2gqwhv9gbX+6Svheo0ICTXRCD9xocill137EFCI79+imy6Welm
	KKUGwpT6BttTsUOnQBmRWRTmXgVB48cgQEp8lrtPEzQNM/hKAvfD3SZEHPbAlZGx+wI3YgQoVS1
	R2qKAKhfRPpFlAo2fMSeENBvrrOw0WEPdA8VFThLcc9DxxMbWdWU
X-Received: by 2002:adf:e19e:0:b0:47f:e377:8d61 with SMTP id ffacd0b85a97d-485872a3f3dmr36403866f8f.11.1788935438109;
        Tue, 08 Sep 2026 23:30:38 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-114-212-219.95.114.pool.telefonica.de. [95.114.212.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfe14sm41956154f8f.35.2026.09.08.23.30.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 23:30:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix ring_buffer_read_page_size() kernel-doc
Date: Wed,  9 Sep 2026 08:29:17 +0200
Message-Id: <20260909062917.89482-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ring_buffer_read_page_size() takes a parameter named rpage, but its
kernel-doc describes page. As a result, kernel-doc reports rpage as
undescribed and page as an excess parameter description.

Rename the documentation entry to match the function.

Fixes: dae8dda341d2 ("tracing: Fix subbuf resize races with trace_pipe_raw readers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..0e30c7bd6045 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7384,7 +7384,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_page_data);
 
 /**
  * ring_buffer_read_page_size - get size of the read page.
- * @page:  the page to get the size from
+ * @rpage:  the page to get the size from
  *
  * Returns size of the page in bytes.
  */

base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
-- 
2.53.0
