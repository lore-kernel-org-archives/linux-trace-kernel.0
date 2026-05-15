Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54248AE3A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853706; cv=none; b=IhD9itbusN+9i6gkHLPAOgKCBi8uD+u+KxItX/1pNZeFKklzbBqTgl2Niq5Cr4CcAmnfa71Ap7qVzVk0GCk+pxzGCS60ps2TLREoXmWiX/NXK1a0PtWOkF9eO8NlHhu38VRXbtKS4ilD2npS967O2Wib2yMuGjhmUToI1vD/R7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853706; c=relaxed/simple;
	bh=YttGrXU9SU/ehJvcfCqasAD7EOs++FbsxXO5MQSKTeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIiWjjShOJ6/tNdMbGm/f0t7upbtP+h0kwvV4EpFuCxRLwRzZ7J7p3NuRW0LLyrhFAEBPudj+LIdLqEldL43vRX0OExOsbuN3Oo8q9DGl/NAuCuDFoY3l6m0fg4coI9k35fOh+iAb/f+Fn/WTdNDJcayE0c285iy1CXjyzmsYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=kNUbS5fV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="kNUbS5fV"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso86860426d6.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853701; x=1779458501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqJRjXl1qsZ28kF7Puh/2rFrGn87SoP9RmWZpVmxPQc=;
        b=kNUbS5fVNw15WpxgqOGmGfVjkuFaCfgr8SSPb7sqlogQSWgXokhLISNK/HorfA3peS
         J5VIZFOsCfaHTzzhryKM3FDVU3C+s0xVjUlbHWRyb16YjZdeNlw5St6wWBnNiQdXugfd
         3RI+qj/WcmoxwKAIJC6UsJvh1Z6L6+on5GYRf9oywH/gjeilmqBwPp0KPnUsSv7uFgFt
         VAdhB67U7ypbHHsiZ+UzI7LM68DrnBOKsoMqXuJKdfaB2ZPnOYhKioRSe07ls9g8RRqd
         9bgPz0HMLANSmQMbkfkkYMH+GCAk6u4cwtLYuPVNbXSsZurnH2r+tfmstxpNzvEWWvAw
         7pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853701; x=1779458501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqJRjXl1qsZ28kF7Puh/2rFrGn87SoP9RmWZpVmxPQc=;
        b=g9Z63U5YlgaHHXIcwJNl7hZSS4uEMy3YNih+2fk0pdwNecfCfppEQlBTy5TOp5uq7K
         43txauarPLMYjKWhyB2LNAmwqZfgieJJVkd7sV/JTwhoUSlKL1rKz5JDew4O78Nlymt3
         BdmUxVUxE6he9w+gF4uakrIooRZfR3KRFtoGKGd2Sy+PJxaXueNWaqxq3MLLoswhBUDy
         yiiAcOKi6YwWC4IEIY5U8YDFkOuuP0tcxugNJdvvAzkKb5YhYbsjNCanYxZzQrjb5iyU
         h2Qz6P2WcsGjrRiH4Dy1dFlKRpw/mV04a/GYeJ53+D8NQJ/2uaLjcPjS/iamGNnlQMQR
         ZGjg==
X-Forwarded-Encrypted: i=1; AFNElJ9vhjB1oPsFPLp9pxNyB7WbxqAtgu0y8r4hTeexDlvEbmA96p6nA1BRmud+JCb1iCD8jFWFEvkfRPlYgnsYiv5FPiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2D1EyB80Rc7xhnJLUwdeUDKVTFRvidhk86MScY+manrvmSwfD
	tzOPM0mzZEUdXRJzr9GCxY1C/TNOKh4NYzImzxNO37EEK69cEFbueid26189LPyrbC4=
X-Gm-Gg: Acq92OEEoMF+7oT6S+rNFzkp3s2NAfZ9jMlambVyuYNohD1W52hz6i15HdjyLsntUcQ
	YLBWWO3cHRsDhlJS75V6xFWcVxlPigLYsEGuQ7dxhk5DFVu6GPHpPNeFj2Vf3yYns5KW2OQwCxN
	4BBIfz+vDOPnI6u7cy/VYfmp+tVHDkBXvWssB03dLd7dArVffQbCPhI/oF3sgqPbSyQa2Qsfwz2
	RrXYX4u920bVQ8FGdbV+f/o6/Ri2mPxCcAazFbGxoeG8ppCTfqGb5z71ymsstB7i2e5P6wjcouw
	0duXVF3dbw+iNpTnLsN2QJNB3PxCGfr0uyS6flcJHzU7cCsYQ0wMWLHTkwV4/vTjyqYR9RVabVl
	Nyk86sjnUMNLexDaftDXBQBgmbbxgrUUglhR5mZS3QhInCl7D+pkfQQ00Zu+z44dR+ooPyg2azF
	jtPoG1gFpk/dj9Hr3m8Ou4qWCqIg1S2++VaLTwNIyddt1b/4n4QA==
X-Received: by 2002:a05:6214:2f8a:b0:8ca:1dc6:9e23 with SMTP id 6a1803df08f44-8ca1dc6a5femr15157736d6.30.1778853692519;
        Fri, 15 May 2026 07:01:32 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908e11929sm52331746d6.14.2026.05.15.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:01:32 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] cpufreq: amd-pstate: Use trace_call__##name() at guarded tracepoint call site
Date: Fri, 15 May 2026 10:01:21 -0400
Message-ID: <20260515140121.2239414-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/cpufreq/amd-pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 453084c67327..4722de25149b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -368,7 +368,8 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 
 out_trace:
 	if (trace_amd_pstate_cppc_req2_enabled())
-		trace_amd_pstate_cppc_req2(cpudata->cpu, perf, changed, ret);
+		trace_call__amd_pstate_cppc_req2(cpudata->cpu, perf, changed,
+						 ret);
 	return ret;
 }
 
-- 
2.54.0

