Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B74EAF9
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759905923; cv=none; b=QDTqzrb94X9fG3WwERfdL6HmMJmbv84sUuyj4Wep4BAnwqm6S4VU6EPTcGVz+m+2UIgTkj0RrgnGaImaPCFKAXZOMWKSR5YVI/D3yzdmQ3F35xiwfLTVdo7LthXaxi1K0fLpOookOhFrg/OutTyrXC2IclgD49H7zSyF6Xblgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759905923; c=relaxed/simple;
	bh=PYadS1dvzEoESy7tFYGh83mfsXXM6Ar6GNIAFMRN5uA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=lQMh8o4C/ZtBrjPRsFJQISB4wofvB8cqNYa31FkeGnTjlbZjd7uRvcqiCy/CthroIBHs/dg6clIxxMKhakbC0dxAaWeEEoRetlFRqOYZdpKJ6CFYogI3XD77JUSvHkmXwfadFf0XLz/pTX8qVQSrNCucDHuTEkn+p5BQvfr5Xz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffHPxpS+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffHPxpS+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759905919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJVbY3GluUVD/bUFHTF3UIglDWTesrXuNLqs55KHQ7w=;
	b=ffHPxpS+Q/xk+lNT0dkZUx9XZNZyXe37o/MHU/pqBz3Rg+zVma2D9WveXtAZjrxGRK+MQh
	qy7r4siYTGqDemZhOEiPsUmJADIw1HyHnnxHKQHMFdB+/Py68ZhzpYGWdeAYd/JNBGsfdO
	A4AtQUP1WobxJUM2MblLssnZbVmjF70=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-6M8GP9TmMJqnAjAwWtOgSA-1; Wed, 08 Oct 2025 02:45:18 -0400
X-MC-Unique: 6M8GP9TmMJqnAjAwWtOgSA-1
X-Mimecast-MFC-AGG-ID: 6M8GP9TmMJqnAjAwWtOgSA_1759905917
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso3987946f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 23:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759905917; x=1760510717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJVbY3GluUVD/bUFHTF3UIglDWTesrXuNLqs55KHQ7w=;
        b=gtUcu1OAb85A3SukqHxma7udfBoKXq2fHS70fOjW7z+IRZ6uwHoanah8g4fIsDwHsB
         SlTviH5wJtHiVBq9pksTvc9WBQpuZYo+NFbzJtPawAopH+FxQNQ1sewQ6QTSF8euxbka
         ZHnRYkmp+ry1UKaqFmzO5W+kjAXQC8ESSHyDkkYFU8P33nrWHVwmFa6yf0E4TyhyvbqV
         Ud1p1YFFNmOQjiDwtmtP8mPEvYCQlZHjLVoj1Z5Lk7PuvBcIZNMl79umM3rN8sK3r7WQ
         109CUZITu3SUTbfZ70qR3eBBM9XsiOZFYJ/XMpY3/0IBIqtj/DajpZa1eJ+yv4Nl/9gk
         xXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf9JhGK08AFhOFBtm7f11k93fg90yCBObOq3NnuwXS/iwV0sWtRajHLFROFd6Qhxa0Q3ueF1SZ16+y0lxIShsE3hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhOP8/v7437+yK5OUZOtDOgS0jKoPQSlmHwL0loXfN7vdEpZH
	bd++4hRCh5v+Yxif2JuNLq76TfktFGwoIlnaWEYY/Yeo0hgVN0X4XkrPHhT0FnRZcZfrhlxxT5S
	KeCNsXT5dxKsxo1t9jIyteAjKV2efTLmEZvelnW43SRikvFwH1t+58a2U6KFi44qYQ4t6+KF6kw
	==
X-Gm-Gg: ASbGncuJRSF403seJZ6jGzi03sB2a3iFNVwdB8KEETZf7kBM/zO0Ba1uJ8/mW3thrRl
	VQSyc7eAjxQZZfrr3o4w+toiqzBaCV/APLkps6rJiJH9Sq+6I41hRcgCaUi4BrwEe5FABnztfLJ
	/VixwgVRT8tuERRi4lrW63CKx+dvZBwGNBwcng1pamrjxarbJTJlNC1/K1HJsGOq+P1f5WMBOqb
	URMXDcWtWSsghQEPmmbUYDeUx15byqidVaVlN4kCsnz9UKl49MiVhI/OSZslgCMccCOEo4wL+ss
	9uQBK/AoSeFwKeoWQdkRfNikggW+Df6iMHZwshx6jYF9zusmVeY/+jnGtb2ynQw=
X-Received: by 2002:a05:6000:2910:b0:425:6866:ede8 with SMTP id ffacd0b85a97d-42666ac3686mr862914f8f.8.1759905916923;
        Tue, 07 Oct 2025 23:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGhkljYRFGEvEIqP5lbKRu7wLfVXBIy1Iby6FD0gYGh4jsIXXgt/9QoZx4JrtpnRnL09JTEA==
X-Received: by 2002:a05:6000:2910:b0:425:6866:ede8 with SMTP id ffacd0b85a97d-42666ac3686mr862901f8f.8.1759905916552;
        Tue, 07 Oct 2025 23:45:16 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c1589esm23364655e9.9.2025.10.07.23.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 23:45:16 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Add missing --quiet option to timerlat hist
Date: Wed,  8 Oct 2025 09:44:58 +0300
Message-ID: <20251008064500.245926-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OXRuDHU_AnygZ-8X3p_GzRCWefgTqyivUeMPg0WVWcI_1759905917
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The --quiet option is available in all other rtla tools and documented
in the usage string, but was accidentally omitted from timerlat hist.

Add the missing --quiet option to timerlat hist for consistency and to
avoid confusion when silencing its output.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b..983153b311ff 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -830,6 +830,7 @@ static struct common_params
 			{"nano",		no_argument,		0, 'n'},
 			{"period",		required_argument,	0, 'p'},
 			{"priority",		required_argument,	0, 'P'},
+			{"quiet",		no_argument,		0, 'q'},
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
@@ -859,7 +860,7 @@ static struct common_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:qs:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -961,6 +962,9 @@ static struct common_params
 				timerlat_hist_usage("Invalid -P priority");
 			params->common.set_sched = 1;
 			break;
+		case 'q':
+			params->common.quiet = 1;
+			break;
 		case 's':
 			params->print_stack = get_llong_from_str(optarg);
 			break;
-- 
2.51.0

