Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1831E231C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308861; cv=none; b=grlxoCgVtUxAUIstEGuHNEoKOmu6ZJ6CNSKiLgcBjPiWuRJzjEQfAwtlSp2MXaqRO4bPPZ5JcQmmGw8jHko2RVkp+VEY9zusOEzTEJUnkvP/zMcFQgEB4SPWccRq+OMSAPQNyl9OKLFVhzvqUb67CW23c5qd5arWHEoVamk1Khs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308861; c=relaxed/simple;
	bh=rDPKRF5nbM8EQhE80nGXFbHhdN7TfLAQ/0VKEszrmh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KejSEOz8SCdmGj0kJR9K3ja6tcSKTPOZ4/LyvM6ooN5PAEeJzXSBXHYogVv6OjVRVA3KGPbpIlFO8WdG5DQWKyoa8PdezPr5Mwq1BMwy2Q+ksv2k0XxsgzFEIjlb01TMb+lvMkdKbzdfFuFQXC7FqzDKCpVTwBG1gsPzVcHPV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zagntXFx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zagntXFx"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33aad097so13659217b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730308857; x=1730913657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQp9Xa4889yKfv5Xap+j/sksIJtCR3GgXWQrx5hFIpw=;
        b=zagntXFxRZqTxnxKXcgJeayJuezPjyn5mtzfxnUrqPMZbooV0xXDnE26UqCXLwJGCa
         J1+dD9iSDg+t2YYTqvEXIGHoJmZcENbSmnZ52VAluSThydDCp0XzJ+aVZj2X4hvX7+5O
         gJry2sSOl5xCuOtxjuoTlv0Uv6zlN8dKZLt+TaU4QK7/264CXhhK+8243BNXGPmegEXU
         nZjmr/aFmmkFAuSxSp9i3Gb045S3Rfp/MS4SysyvsBHV3RZX0bFOgJY0+MQw0m9xjg+E
         +qao1Tu590uX+3Juwn5d3BF8jAXZ/Eodtu75fYMvtbYlmLp1VirvrA34fEZKq79PsTf5
         xLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308857; x=1730913657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQp9Xa4889yKfv5Xap+j/sksIJtCR3GgXWQrx5hFIpw=;
        b=CPomiPr6/8QF4c3x2nufVo+ispazswgJ0Y7KQo7eyf44xTGOKh3q58zPYJrch/chR9
         NcBRtYRQ3gOzV7Uad2Mc/8X8oIo4lM1unU63IABpzDBR77qeRI/KDkXh9gKYA8yv/Sot
         QXXaLD2xJgx80+Cn3ZfFemzASqS6busxo8YnBy6egKcgjcaZahtNa1m/sN58o+W9Gwwg
         30tKmusxRGTZtIV8dkA+NFnrV2cbkNoHZSmoDLEhfOAzhKviDqxlF4ytpoqnYA/EENJl
         fg3bH5cgkg5hAamdBGYq6G3jURIDvVMmFozo4GQ6hMFIluAJVOopOtnIw7xr6XGduP08
         tLbA==
X-Forwarded-Encrypted: i=1; AJvYcCWtfsSkbOTyas2CHbIz9jAcqa7tG8CgGyBwMvSDtOg6XZ+0shK9E2TxufJaNCLrS3gDHvoBh+ho7XQ844TQPprqNpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9wjgxRtLj/l1VGHtwt7h1NljSeYnYpnKl/C7VTxVXq9SfEvo
	+PYHWPOhxvNuO2I93fjkuZ9/X14IdVxa8m4TPqHprkAOreoKjcdDUyB1E7dVCQRQ3GNOuasbe/G
	BOAIdcv8jCsutyHiD148ODQ==
X-Google-Smtp-Source: AGHT+IFmFQ2+ilc/frkLStjSQyf19IpIYrW2nD/6coGLs4CVgqbF3qEYdPRbZm6F8+l8PBqgjQXpJziq3HiTUEpEQg==
X-Received: from kalesh.mtv.corp.google.com ([2a00:79e0:2e3f:8:ad9b:6cde:2e57:6aff])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:d4c:0:b0:e30:bdc8:567f with SMTP
 id 3f1490d57ef6-e30c190221cmr60305276.4.1730308857554; Wed, 30 Oct 2024
 10:20:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:17:49 -0700
In-Reply-To: <20241030171928.4168869-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030171928.4168869-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030171928.4168869-3-kaleshsingh@google.com>
Subject: [PATCH v2 2/3] tracing: Document tracefs gid mount option
From: Kalesh Singh <kaleshsingh@google.com>
To: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	sandeen@redhat.com
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, 
	Ali Zahraee <ahzahraee@gmail.com>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit ee7f3666995d ("tracefs: Have new files inherit the ownership
of their parent") and commit 48b27b6b5191 ("tracefs: Set all files to
the same group ownership as the mount option") introduced a new gid
mount option that allows specifying a group to apply to all entries
in tracefs.

Document this in the tracing readme.

Cc: Eric Sandeen <sandeen@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Reference commits instead of lore links, per Steve

 kernel/trace/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8f52b6527ca..2b64b3ec67d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5501,6 +5501,10 @@ static const struct file_operations tracing_iter_fops = {

 static const char readme_msg[] =
 	"tracing mini-HOWTO:\n\n"
+	"By default tracefs removes all OTH file permission bits.\n"
+	"When mounting tracefs an optional group id can be specified\n"
+	"which adds the group to every directory and file in tracefs:\n\n"
+	"\t e.g. mount -t tracefs [-o [gid=<gid>]] nodev /sys/kernel/tracing\n\n"
 	"# echo 0 > tracing_on : quick way to disable tracing\n"
 	"# echo 1 > tracing_on : quick way to re-enable tracing\n\n"
 	" Important files:\n"
--
2.47.0.163.g1226f6d8fa-goog

