Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEC12FF69
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778037515; cv=none; b=sQyfqaxURwwWEP1SJdQf/ss5JSGRiWg1zeIub0xxqE1ZSM6lAQg1MVMzC6tp1Vx+Pdwzh6+2XGS3HTrSK8OFRoxHW873WNe8kZKRfxt9anUrgFKgQSiIIIB/U9+5rMzLNb62+l04E7Br7VyaEtDblUANNz900CwMnMjyjEwArCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778037515; c=relaxed/simple;
	bh=oFW9BUX/4Mla/eO++X5alZMZn6T/UsyDMMSKbSQM2go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5cBEifCAr4Y/pEPT+E+vQRXMlvDSQfzKXiDQMMWqM9ouO98WK16RUhfg3U8rcHEKb3WRWcupmnUHz4lF1paV2GpfMAQl88rXJNNoNb2n0QySFXoE7wGmKXirpnWthPWSWjnmUcV2otZCv5E+y2zOjrOGUdIoW5xKWWr9p+/N5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj22HMkk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj22HMkk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9a9be502so33489875ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 May 2026 20:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778037514; x=1778642314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yyAt6acVktoGggLFhfqeecMgUcwrLK8LmcMk1I0ocs=;
        b=lj22HMkk8HAPuLChDT2OyDzHD6YZ1xUn7WBYaFXU0XhL2tiw6P1tg72DCtOSMWMWyJ
         SPlLPZqRZnjm2IZWNRzxJCszId7YAwXs/20sezGakPSoclBQ2pl5moBXJOyVLQ/27Bwb
         sVdZnKSwogguNgugj6ZVBOqlRBG5mu4HmGiyq1kMfyS2DlTolerZT1r9Ev9h47LtEf7O
         j/HUBrNI4SjQdYKySofmqv1/AA7THgRHU+yZf+ckZn/9KFYczJ1ahM6OB8p8B9GnhowA
         aGYtIMAOFjIW7S5rIkfJnUfnw2Sxg0ppSDF8VVrjFJjyqEFuw/+MrvWSHBJipXxHAH4+
         3+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778037514; x=1778642314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yyAt6acVktoGggLFhfqeecMgUcwrLK8LmcMk1I0ocs=;
        b=UAHHYiN4kDjfz7veGYZw+9vi4pbsyZa/BoFGDR6ACalexclPjjgwpCEMIe491tdVUE
         x0lt2ZJQiV/3z0WzmvsW3d8Zy5/VrF3f0vc2kgzT5GSp8eztNfKEn2Pgvzs0bbiWeWZ2
         J+yMxJ8v26CcKcie/zq/3Js7J09u2HfurNgH80hOCeeOSvX1lbRe7aeKf/ChWsq4YjSi
         91P/XBUstqv/lXhmPfd9bbkvyCT3rPwgoCvCjLedxxAgEgW1lMLSKRL4jI01HmbJbKDC
         QcqLNL6ftciQLOLdu6tujVO+t2f8riCPF+B3PKmILWo6hvEDaZjHLAqMaAFsZFL/JtiJ
         RNIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Vbs/SnBX2Mq6AuTt1zVbUdmx3wufWOLheHxIVqekr4fDBuv5jdo/boLD8GbSD50iGOh9/367tG7JGq47WbTr7bUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9s+EYiobN2B7PHBFdSU9eC9FzA26brZpbryIQ+uJMcLHwXdXk
	FDLIAXWLCtZtwYBbZYuhPO31rSusmyH1WmbJdccJ4r8mSmkNrSmrqKwZ
X-Gm-Gg: AeBDievA5/8W1eCV+qd5h5kLqvDLpbIv5EbpHbmSip1Tk+dGzOy2+Y0ykCAoXyQdpFq
	1ttksAItsTXVn5Jbv7QGftsPADzlZjXwb8ttCAcI2OLLocYANyzVd4MQG3PNKIQH7mgtJNtHlHq
	sfSJSq+Rob74iP6WBMNPhGpKWMxBxADiiyiKP2fjtDqUprz3P1V8RLZzHL0BvrTVQw43g5GznYF
	MbclTm11dt0CQgGNylA9fKrq5l7ORGmSCX8+OPuLN+zMPulCC4mzYfylQoJKolTSSXYOLRZvmx1
	XUwV2EaTLWNGKXQsSafPNIdBB5AlafT33wvjzmG/3Zdin1rwErphgH5ns/T8ScCdUzwkQpXDS7t
	iaiY2FuuWH5UIuJh74KeQUHrCVDOzHHT7JlzBmjUHQdKHuaRQsjhqM2yR2l8hptK24Xt6k/kULz
	ajhAEVzSmnBWmO1+cPt828rDB+y9VjyYzxZd0YdH0K5tf5PuLuTRld2euprnb8V9EHSs70FR6w6
	0aEtIoNd/B/jQZ8dBMT3EfSy0+fioJOWAdM7/DY4NCEMQGdiD91e+FO
X-Received: by 2002:a17:902:74c2:b0:2ba:7354:7299 with SMTP id d9443c01a7336-2ba79bdb06emr11493905ad.27.1778037513560;
        Tue, 05 May 2026 20:18:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf330a0sm7799985ad.31.2026.05.05.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 20:18:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-trace-kernel@vger.kernel.org (open list:UPROBES),
	sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC (sparc/sparc64))
Subject: [PATCH] sparc64: uprobes: add missing break
Date: Tue,  5 May 2026 20:18:15 -0700
Message-ID: <20260506031815.779909-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing fallthrough causes failure with newer compilers:

arch/sparc/kernel/uprobes.c:284:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
  284 |         default:
      |         ^
arch/sparc/kernel/uprobes.c:284:2: note: insert 'break;' to avoid fall-through
  284 |         default:
      |         ^
      |         break;

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/sparc/kernel/uprobes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index 305017bec164..c8cac64e9988 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -280,6 +280,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
 	case DIE_SSTEP:
 		if (uprobe_post_sstep_notifier(args->regs))
 			ret = NOTIFY_STOP;
+		break;
 
 	default:
 		break;
-- 
2.54.0

