Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1B2D7D3A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776625597; cv=none; b=oYGVeXYga/SbXqqKMbwiKVBTJyDlAWJaU5gUKIjciCVOaiK39UzjrefPnUOnI6XolxBG7hus8W/JGYqYi1k8QVy+deX3IkCA527dXLCfqpnCoCUKAafRycw+QO6y/tPQk06BeDPqNp4YYVxsShbUGp0V2V+FZgmfQUgpnwOtX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776625597; c=relaxed/simple;
	bh=toOFf2xg142rVKdQsq5pdhGPVdznNk8pu3Hk5d0NOts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRuMPZCHbBL/OcwT3vxOO6D1P4PCkaZzVsmw2MY7dwOgriWtbZVnN+lp67AZKqQ+QaMXkq6cHSiQMdiLmAdIWy0+0tkjl2MYsmOKdF1p9cEzdzyeuo5uqVrFVDF9yp6Pksll8hGArDvs1RyUZ9dP1tB4xslFCLB9hXsydo1vN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTeUfGQR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTeUfGQR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab39b111b9so9060645ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Apr 2026 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776625596; x=1777230396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYwumL6ukXBAj/RoXbmDU80+PEG893ZgwxOy7tBa+0w=;
        b=WTeUfGQRH0GwJ71BnR2Q8ONqp1pYQOF5fB3LbkpfMWv8/kqWOSNgxTecNIWTH+bAbw
         zqPLRumgAkiziz7pcobaPz9GnAAZqMSlgwT5S+742lPYZRb0SCvtbzfy6jdqubBe/RCa
         rrb+pw7xibhU0FQVpdPEeb971mYzYRdBbNH8CbJ29nEJU6tTBILRkPhNUzpsgvzHjIO6
         65k4N6AugHi50yENYA7zLIVfaNjs/MeyivTGDg69jcSAWUXhECpCLjQHf010r4F1z+Cz
         LvtsrmLXdlCBdkx/Pk/OP6cuEj71xa3QhtjJRBzYVNLMP2xoMXBPI3+2qBY749JIyjtI
         nnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776625596; x=1777230396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYwumL6ukXBAj/RoXbmDU80+PEG893ZgwxOy7tBa+0w=;
        b=hn16slNfSHsZJkxdPfhgWfnFdT5OqeQrj8ueRBvFRWxG4nhWIWAlfU+hrHJxufeekI
         nZ6v9MCWh6NaNfjTbiefwZw2aH8YNl4aCdtgVO6bYAN8MqVgOwjhXYS2Ir1d/eZBaI10
         w/N9ybQup2vwFDih/OlEPiKq52rObzW9MlDjg0e/qENrKNjsaM9ff3kUNsr0r00Usqzr
         sDMOXd7JDlP/HsIe7wN8k7deqvztjC27xAGmYe59oRnOUydgnZOsG0Uvnp5o6DGqwCG0
         KHgw4FDmN0xj5vRohMfIktL6R/3YlQCET3OHUloCv8Hsga+LFMIyz9+J9FIChMZTl1OD
         z4+A==
X-Gm-Message-State: AOJu0Yyq+2E7yb2+z39tj5lkSD2khKE8HhVibIGP/u8tjglc1htVmfac
	Qd9xd9nyhrk6lM14eHHUXyzo+XTJkEJP/tRSCcZ/CBQ8rzveeVk/Hv1w
X-Gm-Gg: AeBDieugRzRW9kUBLLID+1xcVHLgdTkKHsA4Kv/j2tmi5SuSyz8DYi13vVGWZu7Lg9P
	4MmS4PkV4PBvFkyneYg1zWK45jZVnmOTkivYTNaxNu1X8j3bvR8EHUv9it0dINBqREhHtdU0CHL
	AcaTyT7tEq3KlvKBa9PaqgVRMQYeVajx7ZGqymmLyIYAa6jW2c0TAZsc4mz4+J3WBSEeGMnyrNn
	0O93mGrCp5SqvSSXz18mHEfCwjIOGYGabqUsL2DhefzksHnPhpwg6QqZZCuzKf8gQDxCM9Yb7VX
	JBd7p1Hw2il7CmRDys1+sh7zariaoh9ft3VI8z9cSPxiJgWf4mCQpkcG8rKqU//93udhv/WjAAw
	ABa2Crlv2WJ0YGtpNRSXhqMFCrjruHaXCodrSDB00hYfOJ6clH0DcxaMB6WZXykWqRH0ylDuPsS
	imXI+G5XJXIPuf8t25HToQ+08QS/s72xEATI0bb4WS83nB3wgOxnFmeSfYk2jbS3z/gl4xPwhcj
	4l+BtEuMTFk3hvPww==
X-Received: by 2002:a17:902:da8f:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b5f9e773f5mr115776375ad.8.1776625595761;
        Sun, 19 Apr 2026 12:06:35 -0700 (PDT)
Received: from fedora ([103.181.54.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa17632sm81585585ad.24.2026.04.19.12.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 12:06:35 -0700 (PDT)
From: Ninad Naik <ninadnaik07@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev,
	Ninad Naik <ninadnaik07@gmail.com>
Subject: [PATCH] Documentation: fix spelling mistake "stucture" -> "structure"
Date: Mon, 20 Apr 2026 00:15:27 +0530
Message-ID: <20260419184527.779828-1-ninadnaik07@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixing a spelling mistake in Documentation/trace/histogram-design.rst.

Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
---
 Documentation/trace/histogram-design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index e92f56ebd0b5..41a726cd3536 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -247,7 +247,7 @@ field's size and offset, is used to grab that subkey's data from the
 current trace record.
 
 Note, the hist field function use to be a function pointer in the
-hist_field stucture. Due to spectre mitigation, it was converted into
+hist_field structure. Due to spectre mitigation, it was converted into
 a fn_num and hist_fn_call() is used to call the associated hist field
 function that corresponds to the fn_num of the hist_field structure.
 
-- 
2.53.0

