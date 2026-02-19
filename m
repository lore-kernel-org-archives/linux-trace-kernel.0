Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150C34CFD1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518469; cv=none; b=oyPaoQteyO8vvZHK/x29ZxaJT+8OUNgycrikFwsPnQ0zbdHCAnBtYmCaqtSMxjPpN/NoUZ4W5xPxQR+1KK2mLye00eyXt5hzOi10gyeDjh2/tYaKy8hW3zGaM1MKYl/AK1X6KpR97pLDqoowDClkuIPwr04AVYy4AtJfd2wiPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518469; c=relaxed/simple;
	bh=nQP7wK+Ye6wYmIxmU3SiJET+QmuNicuHrwudrViWMD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQ+NieJksB/xcd5mq805TuA/tyd7+rFrYvBlapNcSJKgRfNuiIC2rHqSowC21Ea8iDIoNsTbvtDABbPhoeZoyP4lUFbdgX1gZpJ49g2imnuwnazlstin3TXKyftbpJh2wC6mByCjveTzlnaggu47JkC7Y8w8rOue4EewM9J8/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VwGrrmnR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VwGrrmnR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so774977f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771518466; x=1772123266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFC9HlnT6aCliYljADQFst4QAf50G/C+x6kbmjPwxh0=;
        b=VwGrrmnRcCIhe7JT8CL6K7mSwlQclA4l6F6qYq23cI3yjTmjYt0Bng+a4RVvgugXGI
         /J585sVZT9X2TgTl3iWXM1iwYUpvQHedP8gj/gmuujGSHbW8r5ch5P+nho3tekXAVSTB
         i2V1xra+a+j3ZTD7wvBpZDAivGk7nwOI9abg7yny1G6cMyrH9yUKnfv6lO40yxF/OFVD
         O3qAfeO8mXFaY4zpj2cqDuVaq0mU1kZTKX1MY77UqnZ/bxxeHW4EQO8UK/08qyo06joj
         3yhBUrmiKOGujlLjxietkt4WzdGvV6HzLJwoIAp3AJVmWVKrkUgAhPwJWuYSthOgcniq
         GK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518466; x=1772123266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lFC9HlnT6aCliYljADQFst4QAf50G/C+x6kbmjPwxh0=;
        b=iIkOxCHVPWavUvPltsagk6yneRhfP1aZ1fd0Xk+GryugdRk7wZt2yuJ6MujC7QDy3m
         BQysmO5aKQ81gpCJFGEUEPov8Ny/F6pvBl+4OGSLfCGj4aohGs0c7eBFyUqOLJZtTfuM
         +jHkZsSMnOZvvpX+IObs0sRGcPpmkGkle7F5HsydoCDWPhFUGIlpxeT/7lsoV1cPgm+Z
         6VAq3pR0LdTlMCc88m4bpSkuGvp844Y2qLEfH97PujCW0G3qq9iOo3QPVGysUWvj+ZcL
         rqWT2HI1ETSCTw52ZxzSuF9Gu/wfxacq9djjR/2YBA5zy7xxnsit9TOMEMEMeet6dXlA
         TBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA3fg3gOom5sW7LoP7zuWy00loQCpWWMGOfguVSvVd4dkg8ERz687mZw/1jMYh1OcML1r66ZdeiNpS4i8+TP0RoDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OPUxUfVqy/S+C+ZVsqUb2ymXTEH2epNFiZX+NANf5k0fGqe5
	bzg/bnRaK0louQHIZPCjg26AEu6xksWHjXHtaH2WNqgEWjlfk04hvpPhTUf0ltA5Vuc=
X-Gm-Gg: AZuq6aKiNV41BlJ8vD8k8QjlcdGBHPiKXCWq8Qs9mOeLQPAZaBt+UwpRpxTFQ2tjh94
	dVmJKalIk4Q8mLaCdzrrztk2I2aogPu/zO1EDa9DCKRoJicMzHNxpq5hdUCCLV7DlKZAXs6oEa6
	pbJtNXWdW4qdqgpGrpZ9ZDkkMZdfY8fvNMy3AeV/lbgoGOSUKBuNJRii54h8tEC23fAWwoL8LVv
	MZCSyLBF8QIWDnUKxcZ8YjFFtSdk+haRPjfTbTuQXVRYfvA6oSGcH14JoqlDSzyaXy7oGLzVPLM
	ms+s82paa0PVlFaa5CnocAq96tnlleLRijU4/OKgmUpRQa643x4AR4fG+fsYOmdz/FKDZ4lLot+
	5l9oDbVjYss7s14dd80/4eRXM/oa8FymwVHY0J39dL9xKWGPUNQ4FDhvH+yHnAbCcnY1edRuy/9
	XNMl5AoH2ae6x/F1OwAhqDMSdmEvAFcNqQrijj6biqwmdorsUjEvQ=
X-Received: by 2002:a05:6000:2486:b0:436:10bc:d718 with SMTP id ffacd0b85a97d-43958e53837mr11362724f8f.57.1771518465892;
        Thu, 19 Feb 2026 08:27:45 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8075sm47324631f8f.29.2026.02.19.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:27:45 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 5/5] tracing: Free up file->private_data for use by individual events
Date: Thu, 19 Feb 2026 17:27:05 +0100
Message-ID: <20260219162737.314231-6-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219162737.314231-1-petr.pavlu@suse.com>
References: <20260219162737.314231-1-petr.pavlu@suse.com>
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
index 2f6fbf9e7caf..a51c675be0f4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4051,8 +4051,6 @@ int tracing_open_file_tr(struct inode *inode, struct file *filp)
 		event_file_get(file);
 	}
 
-	filp->private_data = inode->i_private;
-
 	return 0;
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 768df987419e..57c76d40be2d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5837,8 +5837,6 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	hist_file->file = file;
 	hist_file->last_act = get_hist_hit_count(event_file);
 
-	/* Clear private_data to avoid warning in single_open() */
-	file->private_data = NULL;
 	ret = single_open(file, hist_show, hist_file);
 	if (ret) {
 		kfree(hist_file);
@@ -6127,8 +6125,6 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 	if (ret)
 		return ret;
 
-	/* Clear private_data to avoid warning in single_open() */
-	file->private_data = NULL;
 	ret = single_open(file, hist_debug_show, file);
 	if (ret)
 		tracing_release_file_tr(inode, file);
-- 
2.53.0

