Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE630EF97
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249394; cv=none; b=gkOa0RamFhMMRJ5TY/UWEhw3T+KXBUAg+T4DcYPH2MlRjAGC7vwpe+ohWM7gCCAMvLMfb1uMmitHDTRzd2TLZQRSEQ0mKM1TEkISWVRFpEj2xuRB8g2g+eAWXneZjNEy5pynRH2n/3ZDYWpFdytq38HNCZ47MmKKY/NM3QTmyhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249394; c=relaxed/simple;
	bh=d+Vle/naWPS7QzNS2FVGa4vf3BGBMNuu7Vbe2EcZcxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEtcbK87I5Y/G7Eicd4h17YH5Kn7oeR7J4QXfkjzv7wyfZtzC/Q230nbKrIBYViJFlBzNt+yEWjQMjCVkpAe328kdfwXpq0GZ+O1SR1GTFeHu79jrGowjR5mApONeAdgYWIuuVET/k23sxseAHanYO8lqgzG277CQiQBgthW0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S12IrLME; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S12IrLME"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43622089851so2964333f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 05:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771249392; x=1771854192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtEMv4P3LsYt3Vtm/NRXERllJMmTHuXEYSzyDVKCmoo=;
        b=S12IrLMEgwx4DcyOIE42BKM0gtdhi0KBI6iZmbGEhykAEFRyBUwsGENIuayfZwwOKF
         DPtwFDVT1yxk9xP9q+wdTevGdgUPcmssbOI+MWfrtpI99A4+pHCFbTMzKMZmkUQT/enw
         JLYvSYt2DbnGE6d4ZM9iDvXN3y8qIPSMFf/e37XCt6K7N/IElNwIvp91RlqTHx8befSP
         7mO0jDSJHqTXYuQLYZQBhmLkYB23Du/No6inuTnhZjOaYUrP+cTqSir4nWuWc2pAjSeO
         lRlkhR/NYmd5MMWuSGaSg+boc6Jy++VUYzuroTOF9EJdXezheJ64ZmTr6eYp+lFFc9Rn
         8xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771249392; x=1771854192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtEMv4P3LsYt3Vtm/NRXERllJMmTHuXEYSzyDVKCmoo=;
        b=d75gNfKl0/jC17FEm3Z6DYFIUT12jnNZS0fT776Ceq1qt0Kg9DZvomR9cjdiaXDtbR
         6+VjSrcRZXju/SGdlfYlBi3nDHO1DTq/T18hoUqi2wFMqxcEbwznJiOPu2P10Iusm0WJ
         tx1nGdG7fV949YQ0vKuZR2+SiT6US9HlnZt/jgmqlSm0rbK9gMDYOxGzByf6G8fyITZg
         aNHZ/lVnaqRTv7wP5kX1p6+CdybGTzYYmcDYVQRWNB9zGc+UnydHmWHHosMJYhTWzYS5
         V3Cir/CyimyrDcDJ09XUm6UxUWOXUyBuFfy7InoWN8Em1yOC2/CYBqlNVV4Lbd3+N/Yk
         kWgA==
X-Forwarded-Encrypted: i=1; AJvYcCUUtuKdKt2T6zJ/Mlmc9WnALLX+nqS8FGrDFaPCVWCK8/Xztb0K4IK3olmnD1aO0mLpGsjUEqUcU2XKoNzpT/mn708=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sr7b9dojkglvVXkCkeuQYGuL2K2eahwWOdM4W6C8/pT56huZ
	b9u+9sn8avy3GqfzgaYUy9ccRLN5qibGuQP/fLDdtlwaO5VWz6KFX+s5ZEICgNnY8mw=
X-Gm-Gg: AZuq6aL/Hwnjii0jpMNjklvPuix4qQ+m4atfdK+NOyvhXCJKEpryldHJzkpAJnUygs+
	+q+3Kp1DlL223tskgo75EQaPFwhUw2yoEQzHk29bAMW1gELyqu0meySXXRxPqq/q+yQLYgneuDl
	s+y6oTReBaEkGCNAv2ixXBTAaYIDfq5+R/JqUccMFhgGjspctsZsKcAbdLxIV+MnerEv3fpxQu1
	u8hu+53V01mqyqH1NCHr/fGOGb7RuLiaMEdc3X0/hiLW1J/xfKVPeThiXTUp7GD2fku71DjwoJW
	oEUT8+dUXSHw3tpDZykoZma+UIH9HXRkfMqVQ0HBoPsMONB8JMNoKAXzxjN08nABAvwLXf0TiKh
	SypO4SmDQjw/aKdL0aDuFdOiqv7+ij/Z0UEhwDjUjg9tnBYaghNmthQKIBdCBJGK2fn5+5sjGPg
	pQIFC3jMh4ZngNqYzVhAmA7Tn7V5+cozdrNsAIyZPf
X-Received: by 2002:a5d:5d88:0:b0:436:d9b:cd02 with SMTP id ffacd0b85a97d-43797851769mr15744120f8f.0.1771249391830;
        Mon, 16 Feb 2026 05:43:11 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6ba57sm22103738f8f.15.2026.02.16.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:43:11 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 4/4] tracing: Free up file->private_data for use by individual events
Date: Mon, 16 Feb 2026 14:42:00 +0100
Message-ID: <20260216134247.1311631-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216134247.1311631-1-petr.pavlu@suse.com>
References: <20260216134247.1311631-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tracing_open_file_tr() function currently copies the trace_event_file
pointer from inode->i_private to file->private_data when the file is
successfully opened. This duplication is not particularly useful, as all
event code should utilize event_file_file() or event_file_data() to
retrieve a trace_event_file pointer from a file struct and these access
functions read file->f_inode->i_private. Moreover, this setup requires the
code for opening hist files to explicitly clear file->private_data before
calling single_open(), since this function expects the private_data member
to be set to NULL and uses it to store a pointer to a seq_file.

Remove the unnecessary setting of file->private_data in
tracing_open_file_tr() and simplify the hist code.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace.c             | 2 --
 kernel/trace/trace_events_hist.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b1cb30a7b83d..01af8d88a468 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4804,8 +4804,6 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
 		event_file_get(file);
 	}
 
-	filp->private_data = inode->i_private;
-
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 744c2aa3d668..1ca3e14d7531 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5831,8 +5831,6 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	hist_file->file = file;
 	hist_file->last_act = get_hist_hit_count(event_file);
 
-	/* Clear private_data to avoid warning in single_open() */
-	file->private_data = NULL;
 	ret = single_open(file, hist_show, hist_file);
 	if (ret) {
 		kfree(hist_file);
@@ -6114,8 +6112,6 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 	if (ret)
 		return ret;
 
-	/* Clear private_data to avoid warning in single_open() */
-	file->private_data = NULL;
 	ret = single_open(file, hist_debug_show, file);
 	if (ret)
 		tracing_release_file_tr(inode, file);
-- 
2.52.0

