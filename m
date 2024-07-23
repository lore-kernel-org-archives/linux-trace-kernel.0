Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC615098E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737529; cv=none; b=Pz65h0EVsaVs6YUM2g3w4+JpXFUB3NdGTvaJSeBB9/qQZsrLXyX7/5963VP6d8YFfien5HSfhMAyrZj4oBfSPNjEImBM1Rj5o22r0X1gtfbmGUgLBt9zP0T//DetIfP32q/fFjgza4PCbxbL7gXrvZFm/RgqPCP8hdyfrWyNjik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737529; c=relaxed/simple;
	bh=o41f5Tohm6RdJTQQRltIg3Tz4FTINsoa8D2H8tZmyJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja7eGWPY6ldbIoKSi3Jy57cQwcczdfwTwie5NqjtTkynwZbMo84nmgb0EshAm93v/dQN34FCCZUkIjIhUGPKW6lrI63BP5GR1dkN2z+NAZ1AR4KhGNOYCDcvk70qzTdMGnAZoeJBKYHMwXSckAMXgTBluzCLp6CvIqfIO1O7gGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=wQb6taeN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="wQb6taeN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so3553678a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721737526; x=1722342326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWLWrwOfQQwvpb82Ri05DZJIfVLjHwkbuOCygTlxvVc=;
        b=wQb6taeNGhcQl++VynHTY2Z+gnUvMC8gEb/oQqaGDizGX7jOx0XZcZvgkq9Ddnigy0
         FD7OF00W5/hwG4SZNE/wzHp6Cb/1gMyo1aWyiKhLZlk6W7wyA2VIWOW4wp9Iq4FP2QVt
         /uJpIsVPmnZm9sOyfXy8yX/zBjecZjuVHET4V7WRAgAQFq3cSZXXsj2Fg/s/8EjAtj6Y
         effWQU2SvSFbFpmRW2z+DmcWYvAGZxX2V/5fwjbYqJE4Miemz5jJByk+ncm/P5w/DXtD
         2DMb0XUJrk8jTqJm6M/Bzrex+adCitqabLa+8fE4HYgQs5sBEOhVa4Z4wWcHhIR+tp+L
         Y2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721737526; x=1722342326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWLWrwOfQQwvpb82Ri05DZJIfVLjHwkbuOCygTlxvVc=;
        b=QvCE5ULRrJMxE5tGduMWr9ntLQ36vhOSrXn43B7/qUtQlFDIp7hNoaAz0/bTl0CC3M
         lDAUN4uZAVkFUXrbuH2HmZMD5zRh4FYaMZcF+80pLRGsOizQGlRzvSxpdRf9gud2U65K
         H7l0avouEOdAXh6NF+0SLpnVz/4b+apxs9+/qqo86okQ1vjOwXBI6nBwa/afpcjBMSbf
         XXX7l+5WwX6fcTK0fvCyzkOlZsOJFbzwNxx7yRvFk49N3N3gXgKKOt5Ff9yL95cbAvhw
         ON2+BKyk968PmmxAGQicgIwXShr9lrwAmMTM5jE3kxteDpaAeMxgn2k092VyML32fuLj
         JITg==
X-Forwarded-Encrypted: i=1; AJvYcCXevM9GQv9FWOzAoCiuDwlUSuHvAzwNVdctZU/kAGW4ERlHRsSP0UdFTCB4M4tcO1FUTd2VfFUhXYSAn9imLsTFNpE6K65EFkLHyPOssn7QT71g
X-Gm-Message-State: AOJu0Yz6h+m2JswDZTfW2zwVb1Tq5qrx565o7MbvjPfuG2Jt1OEJIzXH
	kpTp3kAAQvkbUBN5x5uRPFWODwT05e/pWVGSO+BuXs4jGl5U97h4zLcOVZ9IgoQ=
X-Google-Smtp-Source: AGHT+IHejtfZTTOCdvtSWuiN4OnUD6qZPK+5w37awVBNIdpDWvpgnPPs3yN5J6y/7WYA5nZc5yqbcw==
X-Received: by 2002:a05:6402:3507:b0:5a2:8802:8e10 with SMTP id 4fb4d7f45d1cf-5a478b64facmr5881011a12.8.1721737525753;
        Tue, 23 Jul 2024 05:25:25 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af04ba00bd1de83dc7c21243.dip0.t-ipconnect.de. [2003:f6:af04:ba00:bd1d:e83d:c7c2:1243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d6c17sm7489026a12.5.2024.07.23.05.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 05:25:25 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathias Krause <minipli@grsecurity.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH] eventfs: Don't return NULL in eventfs_create_dir()
Date: Tue, 23 Jul 2024 14:25:21 +0200
Message-ID: <20240723122522.2724-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722201125.3fa6314b@gandalf.local.home>
References: <20240722201125.3fa6314b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing
ei->dentry") added another check, testing if the parent was freed after
we released the mutex. If so, the function returns NULL. However, all
callers expect it to either return a valid pointer or an error pointer,
at least since commit 5264a2f4bb3b ("tracing: Fix a NULL vs IS_ERR() bug
in event_subsystem_dir()"). Returning NULL will therefore fail the error
condition check in the caller.

Fix this by substituting the NULL return value with a fitting error
pointer.

Fixes: 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing ei->dentry")
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
v2: send as a separate patch, picking up review tags from Dan and Ajay

 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5d88c184f0fc..a9c28a1d5dc8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -736,7 +736,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
 		cleanup_ei(ei);
-		ei = NULL;
+		ei = ERR_PTR(-EBUSY);
 	}
 	return ei;
 }
-- 
2.43.0

