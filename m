Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01140170A24
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047049; cv=none; b=V1Ft6lrJk5MVV/poBzZcCRycQC8XyLaKKZLxihWvdDge3U/vX/rXLhfH7aaqncLltHl5VLUzPjN99tIlM/yjamqc0/twVWVTjLR+nRRqsSiB9yOyGAqsJTSbzMGxTx/CM7wrY2b0hxtqf0DXwtnVY2Y1PqlSV5KqZcw8TnYhcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047049; c=relaxed/simple;
	bh=Q44mqaTM1SIsrs8CgYvP0+W3Utf1yJBCLC/NqYnwdgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQdCJxXngtgrkcfqYQedVv34fOAuLSI0v54m3G0OsD9G5J2/pECFYcHX18cD2e97INo44AUltywcuuRlaT7kLxqre4yqFR7WND1Dq3tqKdtKXKi1U2uALuS4rKKNY4VyodoTchlpohsRKi37LeZE7lGag6/j3jJj5T1/5YDcMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZNu1TFZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZNu1TFZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a8de19944so14494796276.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726047047; x=1726651847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIfiuZeJznqfh2tkLISY1veWrBubnfMuInZigqeP7X0=;
        b=mZNu1TFZP/sjgle7nJc0LDRXyQye9iEPdzcIxK9TU+Rs8THN/fRQiNCtiuT9BjHn+o
         ffSbL+RNuX+2pp/36oaJiftRuqOvIpRx8YbwiYHzArvXFPbmFf/x6F9w5p/hxD2IqK08
         BkeaORXqm42wpFG15IZdjOEkOL3tlBO5dSEaMunyXHIexQpHokBHxVKeAWh1AL8ISCeY
         1JmfyZ3IAkDH1+hCE+rgLt5yX4dQNnaIoVzYU855BcJBoJh8GAa8B72tOT/mbRlO1AAE
         dnth+JGgVT0TrdLBtGQM23dP5lv4n4sKna+s7pE2qWRWFWdMkSaLBISpbl+Qz30CU+C0
         1MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047047; x=1726651847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIfiuZeJznqfh2tkLISY1veWrBubnfMuInZigqeP7X0=;
        b=RFSlc9jzs7GzoQxpVdFMCkYalJtzfiDo1v0I48n2rcWBayqYCBPzRiK6CL9acCLw0f
         cnUfqhIiaK+S9ttYQoUcu1aU5qPJ8HbdRVr7IbyLiI+x8ZiHcCYu7BBALPSQ2Ie2MMXJ
         tkjyFj6lHLkMMZ/goEMJzWOMzwT3TWq+YSXGiyNW6Pdy6o+/3z3aCp1NTQPe/Urtmeoz
         IkoIkmsIYyUVW7WA/f0MFaUNUhdBdXUOok2eRPiDYWN7rxCYgVpREVrwpOB3I4Vf3Peq
         UxzaPAGTSFR7HMs6PaT39ZY/9lxU2TVOASix+eZJj6C0ud5bhlUX/ko82zu7x9FnkX/n
         CtfA==
X-Forwarded-Encrypted: i=1; AJvYcCUufRj3p9/gjsTNylJFjat2zIAExxFtaxu5b3lMwcbXFOHu+XSoaTxV1x2t56c7KIVH38EilT1zIqJQ16s0q7kpDc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhRCePnAG2EfSU51TKNpqtT45HAIPyZBcW61CJD++lDuzU3Uoe
	OBcnsouLf4MuBceRv8hmGjSQEXD0Lqt6pl3uKXArRT7dcZkoChNmikoIPhgTwBLnhcCo+/LQPnJ
	4cd9Ty+Q010Np8AW9Zw==
X-Google-Smtp-Source: AGHT+IEtNHaw/88xokAWy+UiHnAdlVPy8NQA0O3wwzz1MkIfIbeu6r+aMsbXBRs/4d+Trw4L1hAPe+ThqsYRmZCe
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a25:9390:0:b0:e16:69e2:2028 with SMTP
 id 3f1490d57ef6-e1d34879f14mr32927276.3.1726047047060; Wed, 11 Sep 2024
 02:30:47 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:30:17 +0100
In-Reply-To: <20240911093029.3279154-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911093029.3279154-2-vdonnefort@google.com>
Subject: [PATCH 01/13] ring-buffer: Check for empty ring-buffer with rb_num_of_entries()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently there are two ways of identifying an empty ring-buffer. One
relying on the current status of the commit / reader page
(rb_per_cpu_empty()) and the other on the write and read counters
(rb_num_of_entries() used in rb_get_reader_page()).

with rb_num_of_entries(). This intends to ease later
introduction of ring-buffer writers which are out of the kernel control
and with whom, the only information available is through the meta-page
counters.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index cebd879a30cb..7abe671effbf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3941,40 +3941,22 @@ int ring_buffer_write(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_write);
 
-static bool rb_per_cpu_empty(struct ring_buffer_per_cpu *cpu_buffer)
+/*
+ * The total entries in the ring buffer is the running counter
+ * of entries entered into the ring buffer, minus the sum of
+ * the entries read from the ring buffer and the number of
+ * entries that were overwritten.
+ */
+static inline unsigned long
+rb_num_of_entries(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct buffer_page *reader = cpu_buffer->reader_page;
-	struct buffer_page *head = rb_set_head_page(cpu_buffer);
-	struct buffer_page *commit = cpu_buffer->commit_page;
-
-	/* In case of error, head will be NULL */
-	if (unlikely(!head))
-		return true;
-
-	/* Reader should exhaust content in reader page */
-	if (reader->read != rb_page_size(reader))
-		return false;
-
-	/*
-	 * If writers are committing on the reader page, knowing all
-	 * committed content has been read, the ring buffer is empty.
-	 */
-	if (commit == reader)
-		return true;
-
-	/*
-	 * If writers are committing on a page other than reader page
-	 * and head page, there should always be content to read.
-	 */
-	if (commit != head)
-		return false;
+	return local_read(&cpu_buffer->entries) -
+		(local_read(&cpu_buffer->overrun) + cpu_buffer->read);
+}
 
-	/*
-	 * Writers are committing on the head page, we just need
-	 * to care about there're committed data, and the reader will
-	 * swap reader page with head page when it is to read data.
-	 */
-	return rb_page_commit(commit) == 0;
+static bool rb_per_cpu_empty(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	return !rb_num_of_entries(cpu_buffer);
 }
 
 /**
@@ -4120,19 +4102,6 @@ void ring_buffer_record_enable_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_record_enable_cpu);
 
-/*
- * The total entries in the ring buffer is the running counter
- * of entries entered into the ring buffer, minus the sum of
- * the entries read from the ring buffer and the number of
- * entries that were overwritten.
- */
-static inline unsigned long
-rb_num_of_entries(struct ring_buffer_per_cpu *cpu_buffer)
-{
-	return local_read(&cpu_buffer->entries) -
-		(local_read(&cpu_buffer->overrun) + cpu_buffer->read);
-}
-
 /**
  * ring_buffer_oldest_event_ts - get the oldest event timestamp from the buffer
  * @buffer: The ring buffer
-- 
2.46.0.598.g6f2099f65c-goog

