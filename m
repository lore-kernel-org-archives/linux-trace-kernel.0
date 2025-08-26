Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F7296BD7;
	Tue, 26 Aug 2025 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203230; cv=none; b=MTgjq0sCJiI8P62rnfl00x0eSKP8Qp42ehjHKkwORHz8FnT1GT513qPJu8hwcolxgm4CeCCgUT2Rcvc1To9hpEaWFu78Zjd1HVXyCYToU8EeFC3CU3OFMyoJDVia2v0UtCMo74tCFFg7AOqlFJ919Pyjz1Fp2EOfd/pgZR4+9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203230; c=relaxed/simple;
	bh=HfhlOUNQCkoaUDkzaVR6DYfxjzrLBnZO5cq3xAbdgQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qZugmcOCSAh2K96G2lTLAIt6K7grJm0QBsxcfAflthnId0qsmVl0q/DZ7a8ELGLC7EvQCl3hUqFexryh7EN+Dy8oejJBGZ0JTm4BdIeJ5xFhubGQPlmU/gTWtCoV0w4okeMCdSeS8luZRnZk+caJcHWzsFXPQ/xCJczeEgnHRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgvH79YC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgvH79YC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso46332965e9.3;
        Tue, 26 Aug 2025 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756203227; x=1756808027; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9GUq8tiWVe2q2KBwQ5uL0NJkplThCduW2ScMQxhB7o=;
        b=UgvH79YCZjNQ9XIXHYbC5COcozOrY/luPU8pU5nH9AQi9cnYaGmvOoEQ4iQXFYx/OO
         vHggUyYZsq0yvAqrqSXyskSL8v11QBEDHWZA7lug4j+dO3MythmVps0oiOuN0nuLmhJS
         CwFL8mhjWMwKg9u5HpbR5tS6pzxs4HGep4PCggMLY1pyDdp9Oq1UDFiqweBUcm+OXFwr
         mjhLh3s/vCRlwLiNkLIop5zNOWoH+YQpHc21LwFWXVnZCUexRI78zydSmF3Z9lbgPF9c
         /l5BqQMkdSK0HGSxywnPrOpbe4poP6L5/3aeL2k2MEVNfkSO+N3ZWWMSHE8XJ2oBHVJh
         +9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756203227; x=1756808027;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9GUq8tiWVe2q2KBwQ5uL0NJkplThCduW2ScMQxhB7o=;
        b=HEXHCW3BeIVbMQtP0C6Kst117Eo3VWQWKIcrenV+tp/GZIqrZAMqVppceRQ98PPWiI
         U8pb5iu8z45Z1pnNyEGdmy1CFhQO61ZvrUjlsahKkqKfZtRGk39LsUL2LH71zWha2QSu
         mvaZ7vtzoLbthS/1Ym4Yw6rUDY9GmbJJsL2uh/95MPr+PLI5M62JTTy67HWfjSb10ES6
         chtA7RXtVG3SXgmmFKPyjW19LifFPSSxWAxulhM2Z5rAN3W8tUwRcV09z/dERf648ypv
         rVxUnGeEvirje+fGjqyCbtKN6FFXuEBSRdrpiSIehDn3VI6KtOxn/oD5T8LUW3QFEtSU
         U4/w==
X-Forwarded-Encrypted: i=1; AJvYcCVgMgK44AwFoDiT8iw+/mdwXZ4KRQ69dapoiit1l99b74Geyv+78xt3qP5nQYGPr2h90hkwinfKDgv7q2A=@vger.kernel.org, AJvYcCXCZQQkZLEb6L9WLRnp1eS9bMrHYeF6HlKeOzDa1jt9U5ZM8iC6nD6FIfQ2rm2ZVGbIHPmds0YD8bZLXwHM6LA9ohsW@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNM1kF2fpKnbi1sEqyy2NY4E4XulfzTil0jPrZ1SkRX2iWkhl
	K0VE1zxx+ubez7yFG7etPcJtRQb1YeOXu1RPpaO+xVrY5HK2l+od1uQ=
X-Gm-Gg: ASbGncuVM4zI6E6KFUHSgAoOWdeVfvJOUisXmiiSBrWUFuY7CAVsY4As2T7MqKjvSdx
	KpaB2xu76O1k0rlDAslDfMn/4ffRBM2faK3mIPIyzP3Bs/R/EbLvg98axgV5dxGzsT5yvx+Nw+u
	QSKaQlU/F4hOs3wjiCWGvZuqj2a1pBtGkuegtB0hkT3OsdULY4YnYO2hHOXdcF0lD5VopBqnbbe
	fqo6ZEJ1Db0tLdhssgrpjWd9d7UgEPFliZTtlvMGbZSn6Np9vGEyMxXOxjYrThtnjqU4N+ad7Zg
	IJOyB3vTGpserXO+oXLsdYCFSSHSRs49U8GHsnSsNTpW+u67gTa4Kg/ZAWSF2h5unANntEM/N3F
	B5Qd68q+Ny3yB23pRns2O6NL8
X-Google-Smtp-Source: AGHT+IFhAawnX65LOdrWJkscz2oMkvFgIbga0PjDZYqjlN/j/J/rlUmXoIkurpGi05rLX9Zv5OQOpg==
X-Received: by 2002:a05:600c:524e:b0:45b:6365:794f with SMTP id 5b1f17b1804b1-45b63657ac5mr46011345e9.33.1756203226932;
        Tue, 26 Aug 2025 03:13:46 -0700 (PDT)
Received: from vova-pc ([37.122.165.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5757378dsm143780475e9.15.2025.08.26.03.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:13:46 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:13:44 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace/samples: Fix function size computation
Message-ID: <aK2I2IGKRwmkQuIR@vova-pc>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In my_tramp1 function ASM_RET instruction was placed below
.size directive, leading to a wrong function size.

Fixes: 9d907f1ae80b ("samples/ftrace: Fix asm function ELF annotations")
Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
---
 samples/ftrace/ftrace-direct-modify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index cfea7a38befb..da3a9f2091f5 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -75,8 +75,8 @@ asm (
 	CALL_DEPTH_ACCOUNT
 "	call my_direct_func1\n"
 "	leave\n"
-"	.size		my_tramp1, .-my_tramp1\n"
 	ASM_RET
+"	.size		my_tramp1, .-my_tramp1\n"
 
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
-- 
2.43.0

