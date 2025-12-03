Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DD305062
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773596; cv=none; b=shWYDKXBF7UNWSVU13BN7hXMNMBwbzL1JefMLiGrr//I+XJfLRjBTzKKaBlgLVYCOsGaTN53tXcDFTD9jkNtLVu/ENK9yOaHOmZmaYIC2ux1BauHg57RvmZ4sJ7jXdZJ4pi7aoz4WabcKwWt10RFug67PyLgQLHmOYeoPf5Yj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773596; c=relaxed/simple;
	bh=yjrx4L3sajJjImVzdxgmjxLJPe1GoPkykXthqiJtIZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZGIm4/Mj1FY2+xH4bU32GFDRlUeuXrgdHeGjRxC+pkxsI1cieiNDSax5QKqNpHJr/+yYDb8szoOtjrEENXY4EvLE5NlgSohy/V8/VmVazQw0nEUGvNmJe+jPnPNbvbG6KS5xyakYE8zYt1sqLj/ZAdsYZoANo9ttciumh3CwSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gco5qMX8; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gco5qMX8"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c750b10e14so2436043a34.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 06:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764773594; x=1765378394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhFDBzldCBSrNy/0lQvoy7nCwrmDD18XBqrD7SpXNaY=;
        b=gco5qMX8NymPg3B4+FjFsPChtLnwG9r36nFQkkZSnx1A5ZRkwjROourvvOGVluwEMk
         d78HYLUhZujq+ikkVhyK6TQUKnrLX2h5dznix/fEpEg2bbHLLHZnqcIqERH5Eol/D01Z
         XGbq7PWqlb3GBf4X9ODFQwhxDWpnmCZPFYhODsOyUkcFCsEBHfbWx9riKZ8VRWPZq3cp
         n/28yyzX7NAJwdssZbg89ganx1s0nZovWlsIn2H5nSwYitb1VhRDbbsKtfxAj+fzU4iD
         st1n+lipsRksKu986cA2WQYBaSjJNJD8F2JmnSNam8UIDpHqMs9MzXmZv3DlX9pJsOBb
         Fx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773594; x=1765378394;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhFDBzldCBSrNy/0lQvoy7nCwrmDD18XBqrD7SpXNaY=;
        b=ikJnaxFNO5w7bGr4kbRTS4yYtKUllqhNkucuEhPIjSfqWiNIeJ+RX/S+Ldq3aRsQ7T
         ngPOgNcNGECMlrJCOWBaS8gdq7ESAKnE6ogiIwVU18mDCdyPYszWml9pZHP+mgKVFOOk
         94XScnO3gfQt1F2ve7lw7fnFAYROTACcT7HrXDGKCvYRgL0qMwj31Dife6RXDFqnqq79
         2aJa6EhA3mJfOsiJTfF/u9udUgN9N2EqIlVC5otZJVF/vveY0vHSn0n6oQaQ4ktCcapl
         Q4VPR5w/pXIOZGL004xD5P22HZy+Tk8uS3Gr5/lJv+LyyBayBgOPpFJENVA8G8DZbyMa
         ol8A==
X-Forwarded-Encrypted: i=1; AJvYcCVHdjFeQlvLqsU3R7dKL53OW6MlH6k0r5A99akg80avgnHsGdS8u9b+KHkORwKg9xuagRT+pDWsswu/CTxGJmIF/Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VsrVgvCx8y8le1Vq8zEYS/nkxdC0+kcJGGc6M7HUV/iaaEPj
	+aSbX2sdk4C+9l/KJNU1MO/J1WxCl0wubAo+GoI1+VpFF9+7CKUUqhppSXeUFX3Kj0I=
X-Gm-Gg: ASbGncvKCAe91oMI9xfJ07eDg4jtfyOX+lapNUPDd56JN1oUFyKFEQ/PxVHwJJZwDui
	u81Bbvg7h4WfISDO0wkFy5jvn0V+A49LoHWNk/OflXEc5GmjhbN+kdZV3ttiIURRTHbYz2DxzEG
	FGvshv9L2QhXoYcNasBN0M9YJvM9yG7ltSDBDDqR0OacQ8yTsA75wrO2I0RzqQ5zkOEtgAyMKLq
	b4vJoOj6TsXjrgAU6VtSXyfw2O8QOGLaQmhJtZ6jaLgiLGcdjSqlpsQ07VpjnaMLH2kc6KnvW3R
	AFWoYIkw1mS9wrMaK1nITI6J3wcb2F9mvHTBhx4RazqkmawJ3BRV30uHl+97CMRjCZYPD9DKlly
	LduUG7vxxHZYhS4Dw3kBcbH3tGF+O+P6ztEiyvdcDyoIUiemfH6sgG6d94T17cPH6dOhLIs4vcK
	kh5g==
X-Google-Smtp-Source: AGHT+IHyFhnXZ6FXNeMNq1Eg87AclDDvm19pylcYCAjLrlhFQgzujOLB2bzSm/z8cgcDPmQKgMAzAw==
X-Received: by 2002:a05:6830:4103:b0:7c7:63b6:89d3 with SMTP id 46e09a7af769-7c94db2e9e3mr1502956a34.19.1764773593819;
        Wed, 03 Dec 2025 06:53:13 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm5953139eaf.9.2025.12.03.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 06:53:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20251202182132.3651026-1-csander@purestorage.com>
References: <20251202182132.3651026-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/trace: rename io_uring_queue_async_work event
 "rw" field
Message-Id: <176477359283.834078.538771620775282374.b4-ty@kernel.dk>
Date: Wed, 03 Dec 2025 07:53:12 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 02 Dec 2025 11:21:31 -0700, Caleb Sander Mateos wrote:
> The io_uring_queue_async_work tracepoint event stores an int rw field
> that represents whether the work item is hashed. Rename it to "hashed"
> and change its type to bool to more accurately reflect its value.
> 
> 

Applied, thanks!

[1/1] io_uring/trace: rename io_uring_queue_async_work event "rw" field
      commit: 4bab5940c31b5d8686c56fb3caafad83a5545a0d

Best regards,
-- 
Jens Axboe



