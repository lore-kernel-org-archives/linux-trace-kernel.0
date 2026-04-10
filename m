Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D097318ED6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Apr 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816194; cv=none; b=ZNMb9UxL2q/XiUeBSXS+CduDcsU1Z3ci0dpLW6RxRBJptmsdZG712v1mVOX8xczTrbbVcDjN3FHUaDxLKmkINXN2fDzHk7wyeXffdssfBVKiHkS4SzQMlw0s+OXVBrKc4AEdwhlXjeEm4Z83MWMRyW0h57ZJEdIftc/BDUFciHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816194; c=relaxed/simple;
	bh=6K5SDJnJcLW83y806dtZjaSlA7S0Q9owylZPxn1MgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GHs2a8dycNYKh63QrmL2T4WwXxnBGrM7RgzFc4DFjpMoih2tq6DCZjB0+ndfjg4f2Quwh0mBxp+yzfk56W4f/1H9dDLfynWnltx0ZdrKlHBJwuhLJSX1LVd+EmbW+Sd9qTgaatzXR6T53ypGhpjaaQRXqUmkOmnfUg39f7NBCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUuyTYR8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUuyTYR8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso29214675e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Apr 2026 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816191; x=1776420991; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZqYqE/hjKhGqD9PJyHocGvL7N1DdMPhT/rtuI+6xKE=;
        b=cUuyTYR8tqVpbGDZmdT05Cyd8gSzHp7jB+XKmykGNtyzTNiU8hErQwyZufu1FBcfd9
         oIf8MhO7iVL6PFGj3jWjNHV7a990gsZmhBtDMXYcgSYI69scmHYoGw0riO7NhmFwYwFW
         mvejBjio+lM7TvgRwZFWTw9tSaWLe/uhtdc8Bun8s9/J8asM+tS2rMXy1OJgEB4eCexm
         7nSJfIHuf/YxZW6Q8srX81ESIybmF/Qvea19hEsC4yYCE3oqckONgU9FG62Br8d+6seh
         bIXRq1K64uiuQmfKvWMlKjNovhHMHn0sNhVzvOCaHEiBk77lW+eGipZKRaN2bnbTGbUL
         l51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816191; x=1776420991;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZqYqE/hjKhGqD9PJyHocGvL7N1DdMPhT/rtuI+6xKE=;
        b=PRv59FZLz1v5S3/z479VQlCQ2BFBfX89ViZECVjYy8XNIRqvvqEXDLt8K3Yo63eEQ/
         iWU1WGqgcTNpt96ZbvoTWogjQgUOXKujA4W4zbppw3pEE37OZFBy5cAIoiA6aKYom6M7
         qXJo/GkcVoTAWUXrekW97SGXe1LesW0szOWICDHjEdXlRP+tE/C18aVClSqPgWlYp8TZ
         WKRCc73V/LRvBxicHMOG+h9mf/Q+vEN2q+JmQ6sAtV7ONUaWgfSr6CJRRXVbVT3ZY6db
         t8/OUR7fo0RvGVmo3hkVBVkTJNQBrtvRiEhSdEZdvGb6SgxH3hi+okCuU12GOEuhgTsS
         8jsg==
X-Gm-Message-State: AOJu0Ywl4Y6LLhFvUlPrE6xdyDFqcWlMIyxDXo4AU8bI8DJOnHLgsBS+
	NIF9WwqiI2cCzTwAcZHEwV30iUS6PISAsRUNiBvOqdaf1qqWDmLl+eJ0
X-Gm-Gg: AeBDiet/dUV8P3H5MUjHEm5dAfwixiNWOkbXi/vh4t5NW1AWzGz8rlUb0fX0YbCo1hq
	IlVPWw16mhlBIFNcz8qOL1mw7YR/48gdMSKlYtfBdhNydUJLpfV6idAaC6LHTLTN0gcU5oV/wf5
	94Q608M1r2tWHv665VP1HsFmZ0cF4b3DBzquod1FHmXofpoX9976ryPvMZGirmAwFuNHedu5twi
	HscAcVPHdKSYoWiEc2S8WSodBnJ7JCvc+Yf7j4ojkqzbIPqvMvZDTNgBmXgxB+cGbyVLuS7aVVa
	KVQSVrK/2DRyG1uajRej0AmVWo0UbFq5jSESZ1nF6RGcwjM9sz1t6vn8pR/M7956JVppgsPLlah
	hzNW2acc8NU+EIH3yLiDUDIhIA0/jLITp+k8iFiCPJQjz4dyyiEanoiuWWkcLZLMDIcH0LyAeMR
	ekiG6Pl9Fwmby+ZgOOM8o=
X-Received: by 2002:a05:600c:3b24:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488d6872ed0mr30530325e9.25.1775816191373;
        Fri, 10 Apr 2026 03:16:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d68585sm28811405e9.1.2026.04.10.03.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:16:30 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:16:27 +0300
From: Dan Carpenter <error27@gmail.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [bug report] ring-buffer: Introduce ring-buffer remotes
Message-ID: <adjN-1ydA_kPPhmG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vincent Donnefort,

Commit 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
from Mar 9, 2026 (linux-next), leads to the following Smatch static
checker warning:

	kernel/trace/ring_buffer.c:2243 ring_buffer_desc_page()
	warn: array off by one? 'desc->page_va[page_id]'

kernel/trace/ring_buffer.c
    2241 static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, int page_id)
    2242 {
--> 2243         return page_id > desc->nr_page_va ? NULL : (void *)desc->page_va[page_id];
                                ^
Based on the len = struct_size(desc, page_va, desc->nr_page_va), in
ring_buffer_desc(), I'm pretty sure this should be >= instead of >.

    2244 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
