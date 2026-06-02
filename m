Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8333346A6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415547; cv=none; b=ZtJS0d+oRikCIIcUhGgPhtMoR2/1RznoIaPhsyPZgO91ugsxp7xGf5XNS6jXmZr4OR+jJJ47pEyX92o6bs1ABVd4aGL+FZaz6ksf4wCln6jLBMN90sR8Opid3KWlueAU87jkrjw4Qg8OfdQVhdLJIU/mOM4cZeKMr0Y/eV1hgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415547; c=relaxed/simple;
	bh=cp44LQjrnMZyCk2COrn1f9w07N1mj7690ryjvSOUvAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOi2RmO601GPs44E3CfSWtiArkv/OzcwBGoXCgFTf4Wh8u9hmJWUbxCl1rdw0VZOiXGg2IlxQ8ZJUrRwKBSqd/IFmzXVhxa+fUv+AwkX+EXSVtOcPI39EUiGXEiyD9GqGds73Z2XpUhHUCubiYMhuBBnrIUxUdFt8ioPuwJIjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+NA71Ci; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+NA71Ci"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5174363a843so29356441cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415545; x=1781020345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pDHgdq5w9mGPoumkKKS0Cc0Tkjhq83s0Y5sEG/purQs=;
        b=k+NA71CiA0R7qjKi/z/IPqUyIj8Dd4FciQu1BJ1ErUYEinr/xl4/vAgXMcrLEazuDf
         mgo+KFtkI/P/ms7UdGQ5h1D4+29NLILqpNTEH/qiIaiDsiQAQIhh0VNelyq5C1RxZKbq
         LfXILSLlKWUkgnkRqeFGfbniyGds8sAtvmFE1Byf+IkrO7wmOQC88Pe/YLna4rTzEQpq
         HuX3X9ygCAwdd2WYOdNAZ3HOAFd6iWqgmJSqG5/CN7XlIgdMKSKv5m3S5eRWclhlLnhP
         rCp3g6yzH+u2pCA1/SJA+1U/0baipSD+B8tFqTNippxpbengz8W1yNH9C+x8lvZmsRq+
         Ch9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415545; x=1781020345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDHgdq5w9mGPoumkKKS0Cc0Tkjhq83s0Y5sEG/purQs=;
        b=J2EZuAJNtLRe/bK6zSYQNQKGnMx69wmv/mIJ8GNDaWKa8pKrLrOiqt5h5LJhDiQZ9i
         cMzv8tILyNsTXAK3FDRQfJz8eK56XAqS0DZMO4Btr2XoVqUvbHpZZInlAdPbImkcS7Wc
         FuRiD9aATqlcrLYoti2Twuh3qnq53yJr57oYkzVqHtBKV1XsG3yUJSNnUAHVIU57zQID
         tnucgfWI+hrCvrNKV003SaNBZhH1gna3/1iWTe+yOzB4v85uH5xuLjHtCxpQu3GBI5S7
         /oEtRsi3kMudWtIiEKFtwlJliVfSE8pWCMhaM+sdV17/ErbnUfI2Gfj15mBAQXbEjMBy
         Hqbw==
X-Gm-Message-State: AOJu0YwIWXYzsLaY9K7JaiorhqOcMyeflL3fQ1A0gkk+TIMWxktQZZyW
	Zo0/Hwp2MaSDJPS7ays/GnLxBTOnTWJaDBetj5OZjFzPvbH3+DDBp0V3uvHl6Q==
X-Gm-Gg: Acq92OHqIig7u4FO6256azPezv/7m8zdV/7Xjn++cLHhI0t4kFQ5Oe7yfj/WwJvO2lC
	ciFhUSS5xfexpG2Kyh5U0u3LanZPGlExd0mcZRC+LsvRj/2MEYecvCtXyCcQ1DvUtVwLAJPd/U6
	8zkHXOVTXb/SGVlpAu+IxmEv2sZi/CxvTsuEWp8XuP9x0qzBTo520T4o87LDDFKse4PM5D1hACP
	uW7ZjR16PiEkerwOFJqMSWgkxQezGpHPFUKmXlFjYRrYCy1Zi3jOKaVCiXPNvij6cEoIdYQJ2Tu
	XzNek44AdwuF4Lrsyx06aHIh+K0YeQrKEQAWOSDT7CHr4gW30fhbWzDAiHUv/y4B1DIYZtcweUq
	ojAjMkHOSW2LZXXfxcrINmOH0g4GSYxZypu4EX8M9t7fACPHW77HFEVJmVPX8fJcLeNXo9hj0W+
	RTkztHgM3NjA82+VlBTC4yuzj9LaGsD3Ipbf+zdC+9HSNGe6A6V1u1G4abAan28YzunZ014B7rX
	ANx9PV4Mjhv9F0K2BrSprUKjbiYBg==
X-Received: by 2002:ac8:7f03:0:b0:50e:4307:37b6 with SMTP id d75a77b69052e-51766315b9fmr59588711cf.23.1780415545195;
        Tue, 02 Jun 2026 08:52:25 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775e27cc7sm1520351cf.29.2026.06.02.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:52:24 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rtla: Add tests for option parsing with attached arguments
Date: Tue,  2 Jun 2026 11:52:07 -0400
Message-ID: <20260602155210.60439-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds comprehensive tests to verify that short options
with attached numeric arguments (e.g., -p100) work correctly across all
rtla commands.

These tests complement Tomas Glozar's fix "rtla: Fix parsing of
multi-character short options" which resolves the issue where options
like -p100 were incorrectly parsed as multiple separate options due to
getopt_long() being called twice.

The tests verify four option formats for each command:
  -p 100        (short with space)
  -p100         (short attached - previously broken)
  --period=100  (long with equals)
  --period 100  (long with space)

Commands tested:
- timerlat hist and top
- osnoise hist and top
- hwnoise

All 20 tests pass with Tomas's fix applied, confirming the issue is
resolved and preventing future regressions. These tests will continue to
work when rtla transitions to libsubcmd in the future, ensuring this
functionality remains correct across parsing implementations.

Note: Patch 1/2 is a resend of the timerlat hist tests sent previously.
Patch 2/2 adds tests for the remaining rtla commands.

Signed-off-by: John Kacur <jkacur@redhat.com>

John Kacur (2):
  rtla/timerlat: Add tests for option parsing with attached arguments
  rtla: Add tests for option parsing with attached arguments

 tools/tracing/rtla/tests/hwnoise.t  | 10 ++++++++++
 tools/tracing/rtla/tests/osnoise.t  | 18 ++++++++++++++++++
 tools/tracing/rtla/tests/timerlat.t | 18 ++++++++++++++++++
 3 files changed, 46 insertions(+)

-- 
2.54.0

