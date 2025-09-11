Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1521CC4B;
	Thu, 11 Sep 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564736; cv=none; b=LlGagTzYiWgpa6KTE4tIt9BUcXow0a7hrBVGoHPtCyg/x5XE5YmErhQcyqDj7z6GCZkOhniPISISfPJjF6A4+fDhV0BfyR/caG1DTN+O/tR47JmYRhl97AYcDYfV2UNRKSYBUbWUqp2YjfRQk+/JWGqKgPI6DHDofiqR0vTzqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564736; c=relaxed/simple;
	bh=gJnYOPzdo6ssOCrlDjCBTak4rNUDqYdeq+5rMBMORzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqrC6i1oVgEOXrzf3crcsjUrJ6L64PxmM3RwNK0sUKf2CxbHrHCgKMXJ6azhvDXg412QN8blY87WSLbhScB2lyn4GZ/2IEfNorAJ5NBDoQ8QutckMMbfb25WRTO7WgDSJQ0R9hZawnNtCwH1qjGDD48SPn2BbsP/Q3X3+el2mVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq73+69Q; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq73+69Q"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d4881897cso232910a12.0;
        Wed, 10 Sep 2025 21:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757564734; x=1758169534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXf+831GAW4XGMdB/fNW4pX/VnlQwGVpdh2Lw4++Nqw=;
        b=fq73+69QrkN2ydVehUFkdF3Zt0jGhUjPNBXih5Y15Cn5rJC1yKhhdSG191zwy01Rzz
         +G7Ywz2isJ5wtPtb2C1mS0DGNQyfWbnggzyemUaHZI0eZYl+Ns9oM9zqJXRNcHyoUl7H
         YFnYdsNMJOm90BOXNTQ/jJoN1PAMoWTz5pRb+NXkkLE40bM1XicxkqyLWgZbIk7R77cQ
         FpBoZ39iQDk7eHGGR2oywdlxHsDasAYcCmE+CBqBMDHd/7TVerWcwgsVyNx2YId2H0Z3
         866YLbsPD/fijmGHgq9/BqOxje3b9Kbaks/NDttReg5KOA6w3QJt7YuziQ6KCkOXLgKO
         mwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757564734; x=1758169534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXf+831GAW4XGMdB/fNW4pX/VnlQwGVpdh2Lw4++Nqw=;
        b=QIDVBTCWXas8XyR0DMY5ITJN4XA15de8y8fSjAP3uE0vTt6elwJZhuqyaSVS9Zg621
         7RTGdY2bOMJouV4FR57nsHfiYbhH99i8QQtgFClSkKW5dglVCtB8dhYXGWnDf4KD7/rm
         3Bju/PX2VEgPjox2t2vqeLyNWJ2A6dBan/oJ3vKmEcMejuVAjQ35eFG7wzfUHlgsj4yJ
         FKX0orstXQEHQpfZm3+3XE1TY3j76DVQxhScjQ6O4/WJ6YZiLZn9wGfjdthfk4v+MbR7
         e5X1Fnnfwg8tY92h36fNv3lyw1N1i7bJGSWwf3x3e7H4bI0mxVvYsfByUJGlyORyJJu4
         7LIg==
X-Forwarded-Encrypted: i=1; AJvYcCUTDhdKYF6Tm3fx3Y7WtQzAJj8WAGRs922e9WWFeiDlSbxOhg3ezcDzULK5flED1t1gi8XQb3qxLqk=@vger.kernel.org, AJvYcCUnh7xS6Py1ZTfVW+4352KSH/npS1/ug3E34AJMDAxCgY3j+5W4ihRfbeSCnBoPPL2mp+4/3wAt79JPTwjrblQRhjRh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw30+3lUZv48P4aVuagvYMfhFThTMAaRIbYEpXPNbw9PI1WEd+O
	W16nezOINsEThiIf4vlb206QUb6cXK0j3o25t2fboYqx9pV3uKMYKYfIZPGgLTOj
X-Gm-Gg: ASbGncuuyDKpisM1vbAEIEYza5plfSEtKmaO3Thdv+oIwrOtBkCemXI290RRQY88kp3
	od3ej/aJMVRg9C7Bqq8X9EUg0APoMy8eTGR+BR2hzXvb7Buu/SseNOCI1o6K/DPXWk6XC0vLeUs
	v54zGK/DZY+Asja735pmGzGL7WQTVWbcXY9erImzRZ3XK2VtWxj3UVOz5w1NplSpMG/lpGrc9Te
	0jaJtO1dO/qfqUcrQvrPASRHgqoTHKR4x7dNtd1wXCwc1cYQ8ejM9ggINNQKkWBW4RUkIXOqfmQ
	ycwhoLzHyVuFqxIjHdiWOWtO39g8rqCuGS0+xZxY2QNRiu9COhVTVCN2lCs4JfGUQGtUAdDhxNE
	7acncCi3a6JPG44QPFdK2FVTjc6bvEseLQ7ry
X-Google-Smtp-Source: AGHT+IGC5MjRF/MqVca5PsMuyiyvNqgxC0kBEDkCSVAEXCwvU23v1minb2qLF2nJcMycaftAPbk8ug==
X-Received: by 2002:a17:902:d2c4:b0:24c:965a:f97e with SMTP id d9443c01a7336-2516f05008amr231038125ad.2.1757564733891;
        Wed, 10 Sep 2025 21:25:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ab4345csm4106115ad.96.2025.09.10.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:25:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 38EE3420A6BE; Thu, 11 Sep 2025 11:25:30 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/5] histogram docs formatting cleanup
Date: Thu, 11 Sep 2025 11:25:22 +0700
Message-ID: <20250911042527.22573-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=bagasdotme@gmail.com; h=from:subject; bh=gJnYOPzdo6ssOCrlDjCBTak4rNUDqYdeq+5rMBMORzw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmH/E4/ts+eNbn63tqFX6xzzpc1cOrNmBg3dcZrtZBzj /Om7zpo11HKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJ7NzF8D82nm3d9bdLXSTm XnwiVix4i9uu03+zvNue456K109mPH3HyHA+c5V5dNTVdbODk7pezOZulZ21etnPNarn5yioP32 kM5EBAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here's a formatting assortment for trace histogram docs. The shortlog
below should be self-explanatory.

Enjoy!

Bagas Sanjaya (5):
  Documentation: trace: histogram: Fix histogram trigger subsection
    number order
  Documentation: trace: histogram-design: Trim trailing vertices in
    diagram explanation text
  Documentation: trace: historgram-design: Separate sched_waking
    histogram section heading and the following diagram
  Documentation: trace: histogram-design: Wrap introductory note in
    note:: directive
  Documentation: trace: histogram: Link to ftrace docs

 Documentation/trace/histogram-design.rst | 151 ++++++++++++-----------
 Documentation/trace/histogram.rst        |  38 +++---
 2 files changed, 96 insertions(+), 93 deletions(-)


base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara

