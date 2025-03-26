Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C81E485
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948059; cv=none; b=EAkFTx0vupV+cMIn0sjAMD1iJHM/Elq7n+cHAABLBAKSWcNTevDiBN4LwRjB9FGpkx3rDSJAh1a3z0wYNoOP4oDOl1a3L93kqo5ScxVcFfnxjaJZ12Tb9XS7cXBjVr64hf96YTPb1B9+cMY9EVreVKy1bWjFVdBAMkrO45L6Oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948059; c=relaxed/simple;
	bh=g0dYG+13u3Rs5fuIvKrRbT9x8l7ePHxFiMv96bKZa5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKMXHwFsBdXasIvOSoFY+TzSdRm2TqivRMVas0bMT4rQ8+PnRXyl9j9SWjE8oDSyje6hiDEWwExx5MqMtXBIDnjJG4uvwcA1NrVaLoYYHEZX/6Yyp6h5HAx2UgsLwJtVuRmd0/eoo9ZgDahRsJ6pVbD1zjr5kLfw+05Dy86Rma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=cAVjLMd3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cAVjLMd3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22438c356c8so127937275ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742948057; x=1743552857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFDIX+meos0uclaHeE7nSM0sjioNyPG7nrvKisvJDuM=;
        b=cAVjLMd3LLu2H0rXxiPL+moC6pK3We26LOwWMFSBLzah0hMjc+BveudwqYfEmSSr87
         F0jLfK/5kHBm3l7ukJAj/kk0L1GRvJoTatE4h3kCNBTmbq32sElneJwiaLXGtR5UfIZV
         SKmZGSfFGXA4H5zaXt4ObuY6w8iSGodCy6N4z9F7Isd+BL2vGo5EttfPjdaEVFEKxnzq
         UTWkzmWI7OC3qAEQikcAayb9P/9QRaGuXfnldHS3DeHQ7l5GvdYcTXsSEkjT49cS9gKw
         UExkB82X1Sbni/HsA/KpvwQOzG3dYjeE4sCyRcXSW722XwsEFA7xANstwCP8CSEpX2j/
         fteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742948057; x=1743552857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFDIX+meos0uclaHeE7nSM0sjioNyPG7nrvKisvJDuM=;
        b=BSMrwUSG4dvwJiFZlQcne+22NxKORppkpDSgCaVqi39ak7Gc2I9UlPe7cDhP29UC7x
         z1uac2VpMTrijFs39MOegiY9rwzqmI1EkNc/RmBOiRabM3g1BvsSpITAmh3u073f/rbq
         gu9nBXFl6zTYI6xM97fRzYvNQCfKvWoXQW1umYb55+8HG628YWlKL2vUs407h3cfcAY8
         NsnCiSlJ6f0XBolI9Aue5fly7esVTQcFDJlmmetdaQ1YP/FtPGSxMj4Nl9cgC7lpX/JV
         VdHwvzKYVNriwbXCNn+mf886Zw1/CtOHqscpg/RNAOPB/IfLhoY9u7wjnY9O1Dap2bZd
         6e+w==
X-Forwarded-Encrypted: i=1; AJvYcCWyCFb37QtkYiJ/G3wNvCP8CfP1rdZQlVmTYcWY2S9Fy5q0Q80s42OJY/+eyOXH8R05Rkfy5CsHp+C3cZ/wJ6FAc14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIX018S6VrY9Xa27r211ylgNc+EBsdUI92rqGkJcnc/esNRkm
	cn4ubiFx8arpSGpARAm652+VCYWAialkEj8KtzhqSYqgTWt246Q2ne9Y0zHTbg==
X-Gm-Gg: ASbGncu7grtidvc23ZZtJH6olCUbjDssSl0VWY9Yxblum4XSqVmsHOvQMOyqqTQqj2k
	eKd5wNdr5IVMiDCE0AbgJv8wQsn3r1lJ306WCa0aNFGP3NBF/DrkWQn/seB/xOPlX+Bma4mFVJS
	jxJNjn1gUE+xfLxPN5blzi57eJAm8TuXxGoDhSyYWjB394JxaygJAKr1rZITiHZ8I5+zYEEHmmp
	+roCt112LHUxV17ZD4ZJh2Ju1ipfDGmCWltLQ/wVsGoQy3rMnfgAjl2tCmNHeLJ4GjXbeEQ7zhz
	yfkdiyU8fiGKmT51YCWHmGP+rzIuLgpeDFJylv8PjlIVN2HZBOfHuV3EEDeE5Wg6pK221AivJEg
	G
X-Google-Smtp-Source: AGHT+IHK8sPNE5a8da2vd2P2uilFj9WNnxaFAoXEB1cCtXSAr5mBSWLZSORQW/oGVGD632Z8aRQEGg==
X-Received: by 2002:a17:903:2349:b0:224:1af1:87ed with SMTP id d9443c01a7336-22780d8ab14mr272822845ad.27.1742948056553;
        Tue, 25 Mar 2025 17:14:16 -0700 (PDT)
Received: from s-gupta-ftrace-1.sjc.aristanetworks.com ([74.123.28.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45954sm96992665ad.62.2025.03.25.17.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:14:16 -0700 (PDT)
From: Sahil Gupta <s.gupta@arista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Kevin Mitchell <kevmitch@arista.com>,
	Sahil Gupta <s.gupta@arista.com>
Subject: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64 mcount_loc address parsing when compiling on 32-bit
Date: Tue, 25 Mar 2025 17:06:56 -0700
Message-ID: <20250326001122.421996-2-s.gupta@arista.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ftrace __mcount_loc buildtime sort does not work properly when the host is
32-bit and the target is 64-bit. sorttable parses the start and stop addresses
by calling strtoul on the buffer holding the hexadecimal string. Since the
target is 64-bit but unsigned long on 32-bit machines is 32 bits, strtoul,
and by extension the start and stop addresses, can max out to 2^32 - 1.

This patch adds a new macro, parse_addr, that corresponds to a strtoul
or strtoull call based on whether you are operating on a 32-bit ELF or
a 64-bit ELF. This way, the correct width is guaranteed whether or not
the host is 32-bit. This should cleanly apply on all of the 6.x stable
kernels.

Manually verified that the __mcount_loc section is sorted by parsing the
ELF and verified tests corresponding to CONFIG_FTRACE_SORT_STARTUP_TEST
for kernels built on a 32-bit and a 64-bit host.

Signed-off-by: Sahil Gupta <s.gupta@arista.com>
---
 scripts/sorttable.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 7bd0184380d3..9ed7acca9f30 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -40,6 +40,7 @@
 #undef uint_t
 #undef _r
 #undef _w
+#undef parse_addr
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -65,6 +66,7 @@
 # define uint_t			uint64_t
 # define _r			r8
 # define _w			w8
+# define parse_addr(buf)	strtoull(buf, NULL, 16)
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -89,6 +91,7 @@
 # define uint_t			uint32_t
 # define _r			r
 # define _w			w
+# define parse_addr(buf)	strtoul(buf, NULL, 16)
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -246,13 +249,13 @@ static void get_mcount_loc(uint_t *_start, uint_t *_stop)
 		len = strlen(start_buff);
 		start_buff[len - 1] = '\0';
 	}
-	*_start = strtoul(start_buff, NULL, 16);
+	*_start = parse_addr(start_buff);
 
 	while (fgets(stop_buff, sizeof(stop_buff), file_stop) != NULL) {
 		len = strlen(stop_buff);
 		stop_buff[len - 1] = '\0';
 	}
-	*_stop = strtoul(stop_buff, NULL, 16);
+	*_stop = parse_addr(stop_buff);
 
 	pclose(file_start);
 	pclose(file_stop);
-- 
2.47.0

