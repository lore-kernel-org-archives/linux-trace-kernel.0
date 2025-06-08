Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E31EA7C4;
	Sun,  8 Jun 2025 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380188; cv=none; b=bL7IY3Mmzj9idZY3AmvlgjFzZFZgQUXAog6IGlgnisMdudlqoqUAyYVeq4BrR1OLOcdPWgBlHPHF4GDO+SevmoE1FDp9M8TZ5DJDcSIduis77p5eGV/cYX8aSNF2nwO0fHnCFimP9mU0PPGujltlerU9/1GbnITIx56p3/CjqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380188; c=relaxed/simple;
	bh=Neb64K8+icdlZl7jQtW9fdojzjDMdTwM/JjSIcyswU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBsiElZbWWYMBkhtJosgnDPikIM0Qw8oZOeDUCUnbBXi3vY+tpWlp7PBYCEKb6MlsTBX6/3XYJppJzhnbN7mOb/9YEq8cPyEr7GCdGC0ZmwBI6Kvbf3NOSTI+Zm///HJfY9ULkz/BSsex4nyFwZNhGMAHH6EeSHbWbcTwhEk6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a53359dea5so1102472f8f.0;
        Sun, 08 Jun 2025 03:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749380185; x=1749984985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNieRZ4HqSbrX4DXKz6iAfuxZE7IODvjz8xJBNQ9r1A=;
        b=VyutHpwd0FQ59Nt5V+3EtaihEEcQPmP7gjru5wAJg5aa29d6SyMeZZayantj7Hc/lm
         QyMValV3/0S+1XqTarm8YgG/MC1NTdB/gEPx7zZpmi1OnqOGjl2Ox+mi6drtCI++rtw/
         HTt2BNNO1wY2pj7CzqSt6NwJJLhEqXQyu4pkCkISjOpq2Z45ryqz7mDX1EMgOzfy3VvA
         PAdfbyyQ87NPkit7b6fsZuLXVIIcwCB5v3R7EWYAjQ7r+ESBkVkBCLYdTPO8qF1KarkZ
         sFWpmRb2jIVv5GrqX2gu8MeX2CYnRWldlUO8xCPoOlShfAoqjteVHXK9ONckqlO5jqjP
         K56g==
X-Forwarded-Encrypted: i=1; AJvYcCU1byj+WOos9J7nrvWhhkXNSb9OJiDdDY2Sqp9BiKo+GzbJ3buvqiI9OHJt9BBoH3oYTTurUTTelG8rbvs2PtMYVT/4@vger.kernel.org, AJvYcCUNf+AfRNLJ2gTrQHmBmIrZVcPaOAGq5W6pSWyxgd59bfP2AUSazu3NHcN8bNz4+8aXDBs2QD7DzkLs9xHI@vger.kernel.org, AJvYcCXI5grZBMKyZA4ZeQfxe8JPjkN+OB87XJBt1WaSJeso0pQPCIcPtBwtH/VzC4utp4TjJ7zTw5UTwjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdK3AXnoaeTZ9lSnSvuECSSay4KI/NGtlSwo5tnlI4iQ35v7l+
	DcBKpeppL0HHL+22BFFjJ6oXXDLaNX7F1akMIAKjkJ7Rp/Er2/SUzZ2R
X-Gm-Gg: ASbGncv8cigmdVDJtBfOmcBNHkQQ/jDZDtGEAIBwMR3e+KvWByBsVY6+jwLYn72m65y
	xKY1+6nAVJyhKyclE822OAEhR+SJ4ok/Ee5GPfYSjyW4ws+E+sgxGWs53Gw1IPUM4klZTFlxW6Q
	39GrzBssZkbVsHW63CoEiyGWHF11X15tPqGHfiMdbzmP139RpI5h7gO4UFngzsMmPwnPD4uL+EZ
	JPM9CMZp5aclj+9ammaZWVc1DRUDp6qYBhoDmoZUbxcjmnJCzvqSurLfIM4j2Ty2aX9OcLiPEOW
	oWkc4xfHxh2wtl1PKn2jLMlXkXBjgUldwBeGbiw9x/nynd3kfiMeH3WfML8sJdPUc7VuZ51og9O
	WtyE=
X-Google-Smtp-Source: AGHT+IE6FWLpUv3RxYNo3y/ON4cigS8geNsVC2tFlrGN1YJuEWCl/5SMuM8Sds8ePuu2hZ4Hkyxybw==
X-Received: by 2002:a05:6000:40c9:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3a531786845mr7781909f8f.15.1749380184992;
        Sun, 08 Jun 2025 03:56:24 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm6858212f8f.74.2025.06.08.03.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 03:56:24 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] Documentation/rtla: Describe exit status
Date: Sun,  8 Jun 2025 13:55:30 +0300
Message-ID: <20250608105531.758809-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 18682166f61494072d58 ("rtla: Set distinctive exit value for failed
tests") expands exit status making it useful.

Add section 'EXIT STATUS' and required SPDX-License-Identifier
to the documentation.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/tools/rtla/common_appendix.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.rst
index b5cf2dc223df..a6233ca8e6d6 100644
--- a/Documentation/tools/rtla/common_appendix.rst
+++ b/Documentation/tools/rtla/common_appendix.rst
@@ -1,3 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+EXIT STATUS
+===========
+
+::
+
+ 0  Passed: the test did not hit the stop tracing condition
+ 1  Error: invalid argument
+ 2  Failed: the test hit the stop tracing condition
+
 REPORTING BUGS
 ==============
 Report bugs to <linux-kernel@vger.kernel.org>
-- 
2.48.1

