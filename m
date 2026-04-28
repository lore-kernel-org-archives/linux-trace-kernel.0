Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A63D47BD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365064; cv=none; b=nYZ3lOzcOfgVZ2lmx76U8k/oTslw3fINlYARcdngA42J0W/YWYWZwbI2B4ukGp11HXQeBJi81LT2clb87MCGWy5rvtfG8aGot5QIwn3CzrnUwBwiE0Aoxyov30VPpLNR79kPlaZvck8lIv+o6afq96XCfZzRp+FbkqCsEzZIB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365064; c=relaxed/simple;
	bh=kdAVg5jFM6vYl9m2/kQlN18DRQFcqJUq2xAULl3wZn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e2yDe8bEcWsK9r1uOLiHu7QD5x+nTqY+eJ6gZMcA/GAMDbI7agjoQ15q1P9HKOspBGlsLA0MtbknrATYIdK+QVLpsTjIlNzwu9BW/B4MIi6VIDp0J+IZJRquu4E/4Mg8G62vAlRaVz1oI9/94ohI9UllD22PnWb8lBkVc6jM428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=CPQd+tCS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="CPQd+tCS"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44509921fbcso1156769f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777365058; x=1777969858; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3n+r0PIo2mTPKR5U34fUGLn/JqxQKsLvI0EOtj9wuMQ=;
        b=CPQd+tCS29aTQQhBLccOeNLXBG9dxpm7NqI+WcLZJ+j19tNfnhkVepsrVrvlGDrqB5
         Z9CgmhxilgIDkm4Gb+zYCktYK5w02L6ULywnOqBHHb3CKaUMwqOffAbtyIJ6qF0m0GQh
         mHMHn6yVceqRAk1P76161GveU1U2M0lqxXa721T3H+in8OpQCwx6GNdv/e0vkE6NGxPM
         /v+sIzi0zpTZrLrVPJVJ3cnx4cZVEcmT71QKHfBzR/+eE2LFuMeqLElvBbcAvatZp31i
         A14vbaTqxOm/Y+LVcxDjLq9VxKkO9c3pL4tqxLvKr03nAKSI6NwiMsWtD5hquC0cjRlJ
         3jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365058; x=1777969858;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n+r0PIo2mTPKR5U34fUGLn/JqxQKsLvI0EOtj9wuMQ=;
        b=W/Aom8DMdFiqCb1B3XbpJajVIXE/b2PIpB5zH53/ngXVf5yDrrsgXmP6iFLJu4+O87
         BHtjwl5+ImH8iskO4iUCbd22y7mdncSF/2BBrTYPLU7WSTRaPHEZlB9viF0QtlOrZbM2
         hUyehbklhmVlyX3poG8ciLwPllBnRYW2+DnC0hUZZIbeWe5qHTlb3BfQKqauidSjWv2K
         Ge7C5oY6M4AEjcwgG278BfOQdGwf9JmiDHi6FzpOTKvva0iMvoWH9HeZuuAcuMk/lj6N
         JRIwNcw9dM7NN2nYUQ3FM6fCv7N/JBQ4abCkGRj0faB1bXH7NTVAm0HuE6AdPrPxRaoP
         LYGw==
X-Forwarded-Encrypted: i=1; AFNElJ+wGx39ip2RFySoGHG8Jzo+3yBuwTWOi0HWzng7pl9TwgtQNLYahtQjNTF4J4I2RL1Zu/uIlLC2Gx6VVr+n/1JOnho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBopH7Jrwr0JlDG1tbP3w/40jyNcSR36dL7Rr0J3ZYoI0l9FX
	kXTcToAzBrdVaiek3KTcBpGUvnhLngn8Lfr/wQD50WVWqHIW+ynzCugrpXRhGdpYP0Q=
X-Gm-Gg: AeBDieuwn7ssXV5n/jAInEGWUM1tYSQ5r/DVybzVPp4z0Y0+UEKfyzdbkzjYswOkPn8
	srhn850EWrADKorAszDmJ7xDYkA1aPnMraWWe9/4F8y8Co4y8EMwNt2nuKcWbQsAerXcre2ywnV
	2zRlqTqGqE8bLMBhrRhQ4AVEmI2c2csgTdu93HkYfTdF5V5mZdxFBixKaAgRHHPaPTz4143hvuw
	cfMXs6/oUocsH+0ncFS6bJ+TkpqomTuH7I2Q6/fNYntPVJuqU3as0BzfY2GFFbNQ8e77kaz3GJm
	WfKDi4IUc+YBduTCm7AIlv5JNovvks6drrGC+eqGjGRHJrosOf2mtbhkCFBT9TLEacN/b0YbzOu
	qQeq9MNYAOQSXkHlnFTT/HwzgSip3/GfUouKOjTmk+U5os963JrulWdQFWlUpn93F78fu4digbI
	gEwqAImiH2QUFOIjq3veD1xLZG0A==
X-Received: by 2002:a05:6000:4201:b0:43c:ffee:ee94 with SMTP id ffacd0b85a97d-44647dcf582mr3761791f8f.11.1777365058370;
        Tue, 28 Apr 2026 01:30:58 -0700 (PDT)
Received: from localhost ([62.246.35.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f35csm5210043f8f.11.2026.04.28.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:30:57 -0700 (PDT)
From: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>
Date: Tue, 28 Apr 2026 10:30:29 +0200
Subject: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACRw8GkC/x3MQQqAIBBA0avErBswkaKuEi1SZ2oIVDQiiO6et
 HyL/x8olIUKTM0DmS4pEkNF1zbg9jVshOKrQSvdK6MHPGMSh5xytIRpdQd5vAbskI3h0VpPnnu
 oecrEcv/reXnfD/eumzxqAAAA
X-Change-ID: 20260427-topic-fprobe-packed-v7-1-f44f9bbdedf6
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=msp@baylibre.com;
 h=from:subject:message-id; bh=kdAVg5jFM6vYl9m2/kQlN18DRQFcqJUq2xAULl3wZn0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswPBdbCx2s8+99/LF5s8+yw0fsL3WxLnGM5Vji+9Xux0
 XqW56O/HRNZGMS4GCzFFFk6E0PT/svvPJa8aNlmmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMWLg4hSAqc6yY2T47fJASa2mT7LnWsQt3VkPD5b1z35tYvM1vUXYhC+AcW8YI8Pa1euTXC9
 FWIjUzvzb/cr/rVdUXC5/ZhD3ve/1oTPl83gA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

fp pointer and unsigned long have the same size on all relevant
architectures that build Linux. Furthermore this struct is only used in
architectures that do not set ARCH_DEFINE_ENCODE_FPROBE_HEADER which is
set only for 64bit architectures (apart from LoongArch).

Both fields are aligned on these architectures so the struct with
__packed and without it are the same.

Remove the __packed as it is unnecessary.

Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
---
 kernel/trace/fprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index cc49ebd2a773..21751dcdb7b9 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -181,7 +181,7 @@ static inline void read_fprobe_header(unsigned long *stack,
 struct __fprobe_header {
 	struct fprobe *fp;
 	unsigned long size_words;
-} __packed;
+};
 
 #define FPROBE_HEADER_SIZE_IN_LONG	SIZE_IN_LONG(sizeof(struct __fprobe_header))
 

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-topic-fprobe-packed-v7-1-f44f9bbdedf6

Best regards,
--  
Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>

