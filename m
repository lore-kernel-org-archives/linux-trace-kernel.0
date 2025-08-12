Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB632E8895;
	Tue, 12 Aug 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019289; cv=none; b=eEIj1M3C/Wps5bOYYXtEr1u77+ddpKgBo8clHQuxceKGPZ/nA+d7JsW654ASqZRwbc+kB+GpUUCMj55SnMMXd+zoaywbqx1fN/jzmShATHKpKWSR7npPtnrnv5arwkmvnXJYY7BzuDGaIsK6qUESyS8gTJf/ejFVdv1hnDm2sAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019289; c=relaxed/simple;
	bh=3tier0us37SQg9NvU0fXoUfnzhLWQCIG9q9OBNM7f/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOjMvCri/e5FlRQ+VK53mre72mpBhPzZz5iO/BzfoPSkKliH1otawzHhS4ISzjwzrP3eSbGsT/VQbogyrqCNmQIww2wymrUkCVkrt6RdLIqoQkCrQ4KXWT2pzNOi/Ol09ek22Wwhg0HXuznCyBwecGWzHUGP867Vr4XVaHtQY+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/6HJJDY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/6HJJDY"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e7f9bba93fso681948085a.3;
        Tue, 12 Aug 2025 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755019287; x=1755624087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDwQUm3sZV03381lhrKBeQ+SKs2Y/6ZfkjM7dKYqOtc=;
        b=N/6HJJDYsPndFYRR7Tcw2bzha8LWl9PGKG2E9fmeXTTDnUPq5T4fSlmPPmgVddwwDu
         OBTh1TX3fYD7Bac1HPnKCDkpU7QIYMF+l6IjUrVpcFo7FeuhCOaH2VVST/mB/ukR3mGs
         cWz9m2G3wiewW+cxZfkwS5xc0WE8CL+ZAHlGSfqaVe3aI5AFRIhZ47CEDjAeP2EeZaL3
         t73OFfQpNb8Mr8RfNie+IvWKKqY8YpSuDwRKqOBMAz/RKkXF67SICI1jkDDdXuz1R4fS
         jUOfsO+VCEarWKwkz1Z+M8VtLhoMVWr4I7jtBNMaqR40tCd0RFff4xGh+zSSX8xh6nJZ
         aZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019287; x=1755624087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDwQUm3sZV03381lhrKBeQ+SKs2Y/6ZfkjM7dKYqOtc=;
        b=ZOIjzsCyGvRTjw17Y52RkypJ/gqpL0WFKW/nrWLrKDX8TZXy1q2bLmaQcRNout5iI6
         cvwcc7blu+FZYxU9CXxxMt2PxeilaXatD0R5WrQhR9eZH9ODQeFe6tKlBnkuLKpQ5ope
         L1bOLzRTpeyc6+NgIdG0tdXdBXSfKRJ8svSPKtSNiQQRKY3I2c/KvWhlNgyKTnCvInKv
         PXtAkvgYW/KIOt6LuQ8O9/zWen4lCQhEEY90Hs7gCOia9awsuX7ENXIel9whc2zmE29C
         HrCXS4jLcTE5bVeF7kCzs4GyqowjHTq29AIzFklxDzIlqLtbk58lDUchrXZD8Wk7IU/c
         Of8w==
X-Forwarded-Encrypted: i=1; AJvYcCV1vnfOujp2Iz6JutjlBgijHgzDAt6FayeI6cU1KyBZha5VrT8g5RwE+WT/qjCB+c5KjytriarDmCws6aUuJsT9CER/@vger.kernel.org, AJvYcCVNbz0wHaWpEmglMCriMdrgVloMG9Jd5XRzsC9AkGy/13dwu2vXfCy0wsRjvo4LOamYd7AHnFF4UtJWsqVz@vger.kernel.org, AJvYcCXMWL7x9t19vS7e6CiA7vN1eE9AOMcxDiHSRAfK5KtLD8GyLtyKkfNDAyzy6woa6pwHELMT3HoIhuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvQgb1xwsOdY4uokqafB6vdUrnv5NTbLzsUVy8d5rkRgKUAMe
	Z2Rd0nHZlYDiLXpwDe6py2AZ+jTr/KIAVrYdzkGYLVrm2q12crE/III4
X-Gm-Gg: ASbGncszqPqfDEjFpqR6DIm7dNLfCSNAvaz0xr9dDYPSIr2xa27gFwePz3ROdo9ArdN
	yYEnYzkr5drLS/e7Ya0G4H2Phtuv4SwN2zvmBzkWG+06CPWlwHNxgUzpAFYnFJc7f/48AAtm1Uk
	6g4unnSj5KlQVnbSCZZmCjQffCQWlBwqC+L+aT3PENkV7DsQvJdO/mFhlMQIfzdnC3ZzK6wYiIM
	ZXZ+bQe6aq5NxhcS/KUXsM97yC3v08kWRcbHPX6oVsR+w2UogBjY4wLUMT1It6LwKpsfN6JXNhG
	SdTmCjwh4k1zPVhNpT/6N/qLz6+SWIGkZgfDNLgkFcAG0Ek1yOntB1/qKxE/QkIysLMCo0fQaAQ
	+kBTplAUxO2KLQz0LfuYcESamYQwHk6aF/79hwrSFpdc/cqjglv6T2i6h95rSJXn2sGXjyHjMQ/
	8mntnyE4YcR7/y
X-Google-Smtp-Source: AGHT+IF8AVDYC/rOYxa9bUZ9toRTeHflbFY1OCIB3N09BoqVOFDSpMS621QvkibEM1+jcr2A3RmQdg==
X-Received: by 2002:a05:620a:4083:b0:7e8:14f2:174c with SMTP id af79cd13be357-7e865297232mr2423085a.24.1755019285922;
        Tue, 12 Aug 2025 10:21:25 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.mynetworksettings.com ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82a1ccbfesm863457285a.51.2025.08.12.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:21:25 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v2 0/3] rtla: fix cgroup and trace options parsing
Date: Tue, 12 Aug 2025 13:21:05 -0400
Message-ID: <cover.1755018581.git.ipravdin.official@gmail.com>
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
   name as `-C [cgroup]` or `--cgroup [cgroup]`. Second patch fixes this
   by allowing users to specify cgroup in the aforementioned manner.

3. When specifying `-t/--trace` before `-a/--auto`, trace filename is
   override to default <osnoise|timerlat>_trace.txt. For example, when
   running rtla as

       `rtla timerlat top -t custom_file.txt -a 100`

   when the threshold is reached, timerlat_trace.txt file is created
   instead of specified custom_file.txt. Third patch addresses this
   issue.

changes v1 -> v2:
   - Moved removing clear_terminal from `fix -C/--cgroup interface`
     patch to `fix -a overriding -t argument` patch
   - Added clarification why to remove clear_terminal
   - Added `Fixes:` tag to the `fix -C/--cgroup interface` patch

v1: https://lore.kernel.org/linux-trace-kernel/cover.1755014784.git.ipravdin.official@gmail.com/T/#t

Ivan Pravdin (3):
  rtla: fix buffer overflow in actions_parse
  rtla: fix -C/--cgroup interface
  rtla: fix -a overriding -t argument

 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/actions.c            |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 25 +++++++++-----
 tools/tracing/rtla/src/osnoise_top.c        | 25 +++++++++-----
 tools/tracing/rtla/src/timerlat_hist.c      | 25 +++++++++-----
 tools/tracing/rtla/src/timerlat_top.c       | 37 +++++++++------------
 6 files changed, 66 insertions(+), 50 deletions(-)

-- 
2.48.1

