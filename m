Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D313C276E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955429; cv=none; b=eHu4OBFA4z9B54mJ6LDKZag8u9L+uU7BQsvSmJOUakqBwPXY4Bzq0zRGFFvuhaxydi1zIUhTfGr7llr9v4xoeVSb9CK5Z9L2ch34KZc9fP1tx8Kse33W/KMi57S5Hfxms8kGdI4HwkWMj53pdG4Jvjc4Z+6dVMvwHr3uyLzetFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955429; c=relaxed/simple;
	bh=xWFWLM6PPd4BC7Wru9yX1KPMY1C2JYqGrBIy6wgPD4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GHm7vpEUnIbibosSo78bJLJEANBOlv9RY2NA8qCCqSOrgr/ZOXfsewKc9ONIA672eUVDQ3305R7lXlUVjNWOQMSvAaR71rPkfPwoXWc9Jg4iyoHFNR2TEG8l6uk26kuD6i50RhbUABRPlOnjPCrYuos1ifi776WwLlaR0ynV46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPM6bCqD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPM6bCqD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4957eefd361so23435885e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 01:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786955426; x=1787560226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5f0QojCaRyOlV2E9YXj/J+35e8vJwchULBWmTPvTC48=;
        b=UPM6bCqD5N2XjPGhxBchTZy/KIcrJOFCOk/6RAyZ6GokIynA0/soYCfJ/j8v4tlcX3
         bh3KAfHA+ueXWp86aeKWfvycn42AYYQALACELshe354LDF/a49X8Lsla98ARVw6tf5ez
         bjbY+Bnbzofc571uIHHc09CTKQb7RBn7k/UBWWau7iXAIBSX/Q51WeZwjwxinTUkwypM
         IrV+K2O7qSzmeXK0sJMU+++uyXYptBO0Wu4/FzJJfBbB2Whr0GL8ydd5XLrrtQPYI9yu
         /Ia0KxpTL4YQWfeK138YhVhiOKLbWcRsh2pw52XQtWGUSI4DPVudtio92W+qjuafqmQN
         yk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786955426; x=1787560226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5f0QojCaRyOlV2E9YXj/J+35e8vJwchULBWmTPvTC48=;
        b=GBReAbjvjceJSf+oEllVv1K36edqwRYVF7ulgmHR8ny8aTwaFzoZ/Unv+NEB8A2cKm
         Nj9IKKarArgC1nN889j24A81plxRGdk6jEgO76YBD85V0Q/TNlo3AItJlDPRDq8VR908
         2pQ8ccCyAfXGjqVzZOBirqQaBGUkWzQg4A6im84Z9TnChqqQoo4phJzGLnn84jvK/d4Y
         TNxRdkALLs0wWU4P2mCQVBXy08+5wrhYJNA2reAQE5ZuebCeY3WJ/UQuz9/nty5ye6CE
         ZfQ7qympCL3H3JWDeD2yEdDJvB74QUkyk87+R24HvQL4RPPZ+GDiWY7cgnrpm7hYbg/v
         JiGw==
X-Gm-Message-State: AOJu0YwJ5S2zkuZFj0XX79zZ9wr+savnHrP7gi0bJzB+yY2GJR7LyRqi
	iXWY6qFGKeaAcXsH/V1rd2AV06ecskg6+mUwa4SyYx6rsvHHV40E/dfG
X-Gm-Gg: AR+sD113FoXn02DfTrug8NMtPG8SZEWN6ecoa0JH4bG36twgFJ4ISVu/5sqgeVw43Ty
	yyy+3ffFczeBGvXs2KVL9U1tkWUWDYYtPGoSMIouggvMpXTn3kZlj+cb4tINiVPooxjNiO51et5
	7Wiy9U9et29X8jwnzFpRYdCcsRpw7s/kpskiPjUn2YjAdQ40u0bYopVknP8dUtolWcx6eNb1wXE
	fj3PVQ3epXGwS7AcL9HgEWzDTFRhghs+wi8CKnKx2FISxyjYSdDxQvuonCzQv3mUQKe3GB3eLqt
	v8cKX+bCL8XCLkK3SUJNJ9VFnO1duxxizJupHSBoeA3UkRB0HsnpLtUsfnF5ZuJ4cAgpGwt+WMq
	8wzcjdQCPpcTm8dBZ/1K1ihpo/+Bsum3vkbhAl8dkoSoaDhftN7/ebj1+2KfhCe8+S4s9Gu3crj
	pigWT5mjQesWayoTucETKHhhm0sWNZ1ExzFnfSDFXCQQy5fAnEkl6FJAEXhu2FGSRgq0QDfJ1OU
	R+35geGTxrlnZLZ4cWOlh9PBfqeH6lNyvAflFLa4ABP
X-Received: by 2002:a05:600c:468d:b0:498:8e6:d464 with SMTP id 5b1f17b1804b1-4998797dd82mr292625245e9.14.1786955426053;
        Mon, 17 Aug 2026 01:30:26 -0700 (PDT)
Received: from ptb-02009389.paris.inria.fr (wifi-pro-83-187.paris.inria.fr. [128.93.83.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998ac6afe7sm161780925e9.3.2026.08.17.01.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:30:25 -0700 (PDT)
From: Ella Ma <alansnape3058@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Ella Ma <alansnape3058@gmail.com>
Subject: [PATCH RESEND] tracing: uprobes: Fix incorrect __free function that frees an error value in __trace_uprobe_create()
Date: Mon, 17 Aug 2026 10:30:14 +0200
Message-Id: <20260817083014.999612-1-alansnape3058@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before applying the __free annotation, the original version goes to
label `fail_address_parse`, and does not call function
`free_trace_uprobe` on pointer `tu`. However, after the change, the
function will be called whenever the function returns. This makes the
error value returned by `alloc_trace_uprobe` get freed.

This patch fixes this issue by adding the check for error value in the
__free function definition.

Found by Clang Static Analyzer (my own development fork
https://github.com/Snape3058/llvm-patch-revision/tree/cleanup).

	warning: Argument to 'kfree()' is a constant address
	(18446744073709551604), which is not memory allocated by
	'malloc()' [unix.Malloc]

Fixes: 8b658df20658 ("tracing: uprobes: Cleanup __trace_uprobe_create() with __free()")
Signed-off-by: Ella Ma <alansnape3058@gmail.com>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c274346853d1..ccbdc96e5578 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -533,7 +533,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	return ret;
 }
 
-DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (_T) free_trace_uprobe(_T))
+DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_uprobe(_T))
 
 /*
  * Argument syntax:
-- 
2.34.1

