Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C54305E1C;
	Tue, 12 Aug 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016072; cv=none; b=Lm/JsIbvlzv6JhkJ7B59ZyoKnSyn7MZs5gz8kyejNaeWjnPsYcQEB8aZ+QfcOTnzf62xqai/xToojQTVmUSJppPVecLzhWdYer/Y0BCfoaqNH5QKuojnrYZPhjpo43C3fKOLini5b1YBHcBVBQmSK21P8h/tq2ykqQKLChGBEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016072; c=relaxed/simple;
	bh=H4wHN42+zKDQDW19yMF/FjeYkLlXStajbQksxijv184=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIK2xjmDd6SIkTngXPi/pPxLnftxm9n7oy8tECHFdqIC7TPiA/YmCWKoNDTLRr0oTDPG4e0NAo/SyuDsK8597EKhqXE6EBYUxby2/FxvlRmrq0kmXfvLePonfRtkxixA6C8RrwZT7knjeaauzm0SCOhS4cw7S8VUmoGOrLHm3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGMkrphs; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGMkrphs"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e69960c557so858444385a.1;
        Tue, 12 Aug 2025 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016070; x=1755620870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=872DLzccGLdeccFMNiMQO9zyDCZsoO8QTCAZbV7RhvA=;
        b=jGMkrphsb0BYnfetforWuB0UmJiWRAyFNtqi7E3tZunPdddeP8aVFRQ6v5jsZcZwai
         60jG2OnSLN0HSF3dgsItBBwiK/LFkfGQkbgsIZsTLsiZUtPUV8MPb9VMqful3vm0e3fL
         /pPjr5hQXEIZSEc7wP1tjfdb58XWxtITWRZFEu3x/kHv92ePVMsOtzsbwkqNchkN/Yy1
         8m8T+2tG8oOcSXsLV7k8RjxIPAP+/3UGflVPvuwNEXzOX0C1nm3MK0SvWPd+Tnvcg/Ok
         ltXFIJQmoMppiThvnFLXC7l+mvxwushKmczOJJk0CV6fsSd9ZxhXZ7VvP3wQUjrHeWyD
         ZFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016070; x=1755620870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=872DLzccGLdeccFMNiMQO9zyDCZsoO8QTCAZbV7RhvA=;
        b=EFd1WlvCij1uvKK2+aM3ogn+Xf4zu/C6oL8VnwxKElgysyaSZvxk88Aobs4fhsdXBx
         bdPf5l6P94d9Xb32Ew45THwT3DexJP9fO7kD7tE0bY6FXMSOKRCOLqNVTOdDnf8kNO0Y
         ewiqtWsAsZ/Nihb3tC3bM0b3qyOhEW9sEBTwMF5hCP3beyJDYUl81jZqTQZ6YfGiNe2V
         W9Hm76LwqRc/P9qkk9k0JxPqvR66fjb4Zk0uXX6aGP2AR/yX/54i5oECLy5BnaUnAg5r
         RPSioB6sTIUNpDLifyk73Aqs9CqjlMnr1OELwN1rBD7130dwlZMGLG3zVt8c1kW5b8gN
         eOgw==
X-Forwarded-Encrypted: i=1; AJvYcCU2TDzhJ1It2jPUrn7MNqpHV8eKosRob8ohBPPS32hfg3gPUijHkHnl+ama6T3zydP+l8GVBZeT8kHqqHDe@vger.kernel.org, AJvYcCVhDBe69k7+x7Ion26fykuNvEo05o1xRTSBoAtCXEpX1sjdhkY/cgwUwN71q6SWrPMziKy8ueEiblWzAZVRqDW7SlXt@vger.kernel.org, AJvYcCWL6xVMOttoaGwJhRfZeE5Nz/L4esj9awkDASANZS09TvTQP7iaofH9Yrcu3Lc2mVHomrH0WekjqYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHFFR0LX9gC+ds0lpWWv/ViBrhJOFpEbaD4ZM40kFpbWtL2tz
	D+zksX2y3YcFJvDgWHo/qU/VIvkomo+x4jbTj58vpAkgMOvRoQdzwgiV
X-Gm-Gg: ASbGnct1yChKkWf9XzPzOnfC71yuKh5/FOC8cy+ZGu7CHgV/XgAY9XJ625efx3MS1/q
	zHRKwmBt+q7TJe6SFTgEJKorXB58j1LWlTNSSy/nK7RNkt9AN5sCH3slcX1DcRuvNoAWlNSkZ/+
	/RjGmTrzZVwKa0w+24hbpwHbW5WWyo25s94mkguf/f3Zt2APux0tJ6Qm/aeiAdx0LhfdcpOadz3
	2V5zg5ELdNpCs6C3VPq4PCOhkfA9nVLqSk4twqA/bR1cXu2TAAH6rREt4bLPEXRfU9z1grPmyi+
	eL1l9k9KofgYGc5TVlgywMIcVY29H5/uR+G5skT02/B8x6HBE8ACiL/cJucTNYrrHvbHgaGGg4o
	0geOcbJiOt7RSm/mTcfqPlZC0hKTq9ogpykQvZklTJ/rfFyy2VINpZChoPa8Iv+kXZ239/L95yg
	wOLtyqx2zvMdh7
X-Google-Smtp-Source: AGHT+IFxhKZRHNUBkF8fW0WhG5+zFamuxSg1/GhEXwahNWd7gHiivmN+ywTMT50AIlpgMLveRmN0mQ==
X-Received: by 2002:a05:620a:4ad9:b0:7e8:5bb:b398 with SMTP id af79cd13be357-7e8644cad80mr37414685a.9.1755016069413;
        Tue, 12 Aug 2025 09:27:49 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.mynetworksettings.com ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8079cfcc9sm1269013885a.29.2025.08.12.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:27:49 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH 0/3] rtla: fix cgroup and trace options parsing
Date: Tue, 12 Aug 2025 12:27:29 -0400
Message-ID: <cover.1755014784.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes 3 issue in rtla timerlat and osnoise parsing.

1. Fix buffer overflow when using --on-threshold option. Currently
   passing `--on-threshold trace` causes rtla timerlat to segfault.
   First patch addresses this issue.

2. Make -C/--cgroup option more user-friendly. Currently rtla timerlat
   and osnoise parses does not allow to specify tracer's threads cgroup
   name as `-C [cgroup]` or `--cgroup [cgroup]`. Second patch fixes this by
   allowing users to specify cgroup in the aforementioned manner.

3. When specifying `-t/--trace` before `-a/--auto`, trace filename is
   override to default <osnoise|timerlat>_trace.txt. For example, when
   running rtla as 
    
       `rtla timerlat top -t custom_file.txt -a 100`

   when the threshold is reached, timerlat_trace.txt file is created
   instead of specified custom_file.txt. Third patch addresses this issue.

Ivan Pravdin (3):
  rtla: fix buffer overflow in actions_parse
  rtla: fix -C/--cgroup interface
  rtla: fix -a overriding -t argument

 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/actions.c            |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 24 ++++++++------
 tools/tracing/rtla/src/osnoise_top.c        | 24 ++++++++------
 tools/tracing/rtla/src/timerlat_hist.c      | 24 ++++++++------
 tools/tracing/rtla/src/timerlat_top.c       | 36 +++++++++------------
 6 files changed, 62 insertions(+), 50 deletions(-)

-- 
2.48.1

