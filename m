Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6519149C4F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 16 Nov 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771656; cv=none; b=SOW7tYTt6lZa2nCZ4wNxxD3sYMby+zDXPXgNG6ilQimJlVIz8HTqZB91Tu812OPNiVMdvDnYCFzheoluU+1MiQTMqEPR2YOCqCwrG3blwuTjvrwGQv/hKPiwlzfffqvI7Ct+V3CG5JCXWmS8JmMQl95w8yMr/RHC9FlBEJT5/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771656; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=Q3hKpVFnrv2HEXXaWGsmELw3zOeLVbcSfR8FEobPM/p2Zn/fEsbSa3XlIssFxEFj5N1EGzIR/5ksMdgycY8r+nz3lmvkYwsAHur7ppBQ20Ku2id6I/dRi/NqdgbpMGXPD1naUMXAcaShhzgv8SkeVYIove5yh49udbZPrJ4Egk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+ukyiEF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+ukyiEF"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2841356b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 16 Nov 2024 07:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771653; x=1732376453; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=i+ukyiEFw5EakIjAe5PU0/7i53ki5blRsy18x9QkvGmx2YYNbdlTQa7qt8HhtlkxJD
         bv19t7qpwFJr2ADyZs7KJ/DqOxsYXnnyym4EtT5ecYgWK3I4CdTkO/uW20Pb5Vz9FP3x
         KuJ2dirx/txHkoz1dh2VjXSrz/GG/lr/q2sniRJOHHozu2cPzrojU3AKCpiN+KKUNKOV
         PI2yvXjwRl/p/Yn4Nn8GScFjfajfvyONmp8b9qEAAVoAjEtatv9ClfvPuDCJRmMlYp8P
         nL/2pG+WWqsbEw4OHrwiNJ4JOeQr8dz7rCZP66yzwICVdDIHvNAgsPfmWyNsCSisKeUX
         8RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771653; x=1732376453;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=WI2CNfUcC6UrR1ZeHrv2FeOI2cVrc7CMtRs9zmXALn3OvorFBZFWOPS/XxXHxNzWgV
         2ARStPN7gdfRrBoT5jlvPDaBIHNVY4ARVGXOgmorSvsPJlifxyqw/8UAZ/tdGkdYcrBS
         XKHUEwrErlRjssm7LGTW2KVHyAM9+dVf3y8x91KKkmRudKVnSX4h+WQ3ocNRfBczbkwQ
         vTOqMDlVvU/vNKhLVWbgKJ2wjHZ+xkmeSwLPMz2Dw1eEmZ9aJ6kLaAkye7iXsQAZ64sN
         Ov9KBb/L5MRUy6dhvi5Cx7vcN3YyWSFw2slW+kKhXe55BSxZI5yLyzOMeNYLh1CMSGRF
         Q++g==
X-Gm-Message-State: AOJu0Yyz39TKSLOeDRkyqjPXYNVrkRK4tbA30Qkr7WXV9JYNmnXgEBwr
	nNX4mx+q5o1icIWxBkCpA6y2+zAkWEAWCM4FNKu9fStK+Nn+JEfNLpdFYQ==
X-Google-Smtp-Source: AGHT+IHmh9cLxUac9urUirKsjWqgxd6EXt0Asas2OjD/O4YPSFMfpJ319SUlpmivtXZcL/KLtK0o0Q==
X-Received: by 2002:a05:6a00:1144:b0:71e:2a0:b0d0 with SMTP id d2e1a72fcca58-72476bb977fmr10170536b3a.13.1731771653677;
        Sat, 16 Nov 2024 07:40:53 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771229d2sm3159480b3a.80.2024.11.16.07.40.52
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:52 -0800 (PST)
From: "Van. HR" <yawarabasz312@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <d7c53bd48fd6c9eec149bb67d7f4fa00cf82dd62a8f51b219171fb72eb8fcb51@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-trace-kernel@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:50 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.

