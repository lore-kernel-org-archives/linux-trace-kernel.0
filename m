Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A61B86FD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327462; cv=none; b=Uwf88nGZ79/JaUYx46l5Rt9dMoblEzd8SzQrXSYELKMdY/dBQYDqm5CLGO+36qIlJu5auCaV4wV0KcR7CH48l15A7w/pjQHBdJJ6GNttg59uwTAm53i2qzOkpNwb300C4JdfClBaRJ+V+IonF+EuXRHj54IU/xttpcx79R3iyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327462; c=relaxed/simple;
	bh=fZy98nF3lGPRACLnzWV0B6LC4b609acfD7JHbx8VXNs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BI9mLSXMlUrmVh2EkoRfqKwdA30Xnp8vnG3qcUP9DGCxYA+9blFia1JlKIW2kvLw/0nI7CgnfG0OHbMUtLg5IFDKhYjfHdqyzLriJoyYNRWtah4x9i1yYCUlfPzrdyrwQuv9xwEKZodGx2YxEMEs3hKG6GlTewiqru5D4XEjpes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cLAxATG2; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLAxATG2"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7039e4a4a03so614040a34.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721327460; x=1721932260; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhSUkj+EOk8Y1j/3L/4ALuzPFdB2LmVxWhdONm5QOfo=;
        b=cLAxATG2UXVWcMW2WEQl8bzkpm6d42ZilXu8TmVe/thqgittQ5Jsmagi9PxDZTs3wP
         lK5KTJKJYUzBTlpx+YyG00t97Lftju/Tpql4DBpORuiEH70YJ6fp0r2CYRgRcO2C66Bd
         3bRCkkTIN1LcTHfVmWCSUgYiTCpVMf5riM+nnf61l9SKFS6kwGkYBWBO71SCLCfWzp8Q
         Pu85nIPtxUmw+vzBuVKRe6PkNDw6SJ5x4nC72vfeMqDMWxoVnnNc7WtEfIOGCgmZv3a8
         9Yl9N1U70jMamuhERQmgCpdpom85YaDmjds3fvzi7TcVQ1PieWX3HlqamPm4/9e1Hhbo
         G7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721327460; x=1721932260;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhSUkj+EOk8Y1j/3L/4ALuzPFdB2LmVxWhdONm5QOfo=;
        b=NfvK+nwcgEJl0DrIjtZ9r/SNv+3OMgegKcJMpdcfN+KnniR4d7r0dO37btib0phlix
         Qha/edNWMEfxeK1heEywZEFcZ7EVLXYbBOdTfQCtuA23SnaQZMyEAUTeo62JqAaKCb8r
         9pPT87BTAZlt49VSU6UV0b0mbC55qgXY1Zn+2lRLdqxN0bxCU9wke9H4p8FVRZbHVtl9
         GoIRDfGDd9YfzOZeR5WDfko6ihW3iA+dRj0rSNN3UVR50eLPe43ihGs0OfuB7GH3e9hQ
         ZMiqnqzdwWNfOhoHJff5924BzGusQ0oYYzDwSjutPJQdhotcRPJCHExCYE7WhO7ANfa1
         F+OA==
X-Gm-Message-State: AOJu0YwOg2/4N+p2ALRwTO40ssbPARcUevIYMpOZSFlnO0vlZlDwjeRm
	v07BKR7d79vDJXTHsqMYOKRO+lzc8xWJ+mDPHpcf60o1Q2eAFdc+Lg10MwM6Gm0GdIEib2qTUUV
	7
X-Google-Smtp-Source: AGHT+IE9UI/tXpAkS49jJTV6Qbc64zpbjrPkyzyV3qxnE5nCXaA0fWa/IXcZL0nSuAms1svRzb0trA==
X-Received: by 2002:a05:6870:f112:b0:260:fbc0:96f0 with SMTP id 586e51a60fabf-260fbc0abdemr1676001fac.39.1721327460079;
        Thu, 18 Jul 2024 11:31:00 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8d5a:14eb:55d7:f0ba])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-260ee759799sm438502fac.31.2024.07.18.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:30:59 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:30:57 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] tracing/kprobes: Add symbol counting check when module
 loads
Message-ID: <1c775c89-42fe-4c86-ac6d-d97170885ae8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Masami Hiramatsu (Google),

Commit 9d8616034f16 ("tracing/kprobes: Add symbol counting check when
module loads") from Jul 5, 2024 (linux-next), leads to the following
Smatch static checker warning:

	kernel/trace/trace_kprobe.c:828 validate_probe_symbol()
	warn: missing error code here? 'try_module_get_by_name()' failed. 'ret' = '0'

kernel/trace/trace_kprobe.c
    815 static int validate_probe_symbol(char *symbol)
    816 {
    817         struct module *mod = NULL;
    818         char *modname = NULL, *p;
    819         int ret = 0;
    820 
    821         p = strchr(symbol, ':');
    822         if (p) {
    823                 modname = symbol;
    824                 symbol = p + 1;
    825                 *p = '\0';
    826                 mod = try_module_get_by_name(modname);
    827                 if (!mod)
--> 828                         goto out;

Is it intentional that "ret = 0;" here?

    829         }
    830 
    831         ret = validate_module_probe_symbol(modname, symbol);
    832 out:
    833         if (p)
    834                 *p = ':';
    835         if (mod)
    836                 module_put(mod);
    837         return ret;
    838 }

regards,
dan carpenter
