Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461F1B14F3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900303; cv=none; b=PnGilTdxG4wy+dHKY1B1gmgnZlKGDfanTxSFg3LMv8zY03onK+yx0U+7JCLKTkwWQHGlVMaAU2nV3E30hkxg83GEqipi5sTLtRJ6hrgtTkzCRtfiezYhx8wafW4q8NrgyKHxukiTEa5x3uxMgFm8IIpvEq3PK1WzarZWASLajmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900303; c=relaxed/simple;
	bh=Pr/Ikd1c+WzW4xHwcwh9vXtLfFfjK/HDJCD0eaHhW+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2m5AraSOAeB5KheaFJqp/+7t+x2cMhddp0xVoScvXtcnc2qt8OXjxX807mlJUNPEqCWGSccD1QueS9bMA4u+bHHMGHUJyi/tCVwbrKhpX+eKwtBJnSI2vG9nbVhoqPqpdydQg2DeSO4TkVs2e7TjgzAyxOTgAVp5ft+uo6pX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZuJojiHt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZuJojiHt"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5295eb47b48so1385450e87.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718900300; x=1719505100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr/Ikd1c+WzW4xHwcwh9vXtLfFfjK/HDJCD0eaHhW+Y=;
        b=ZuJojiHtM8pqmEOcImp4bpsv8cNm+3QGxS/HU+mP5Ts2QW332SAfN6gsAtju68IMvf
         CGJkAe5wnipN2iiHMuGNIueZxL99jNrgCSbKXr7yij6WAKPks+eQAG4ehVUN8mf4yTd9
         eOWvIxMSj37sUyhSXUrAnXa5z3UWU3DKM2jts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900300; x=1719505100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr/Ikd1c+WzW4xHwcwh9vXtLfFfjK/HDJCD0eaHhW+Y=;
        b=FwREHlLvkYSxX1Q9uSAPy4U6nRjvjH7EDNeFqn8LhMIFDGLOV/G9OeORAH9R5NafHr
         9I0AvOBC/lDZ6+9652WaSBapyLOfdYcVaP9VT2QkGoAk4TsCfeb8ffbIlz0R/W1cCvzx
         phi0J8ho7q4HNctyJJK2flYwswsW2e0KaOFF17trVWZAPse3im+ZF+eHX07mLcz2u9Bo
         aQ8aHU0NIQW5XB3HpR8psYrgCh12TdfUXoNNx7J3ufPDDqPtyqITE+Yd5HOGMPSIRESO
         a07HtnfZqb5rXfWkg4s2WwGS73z6VQ1E6mKPWEtkmjs9DJy3W/n28yzx93/q/iWtkaq0
         k7ew==
X-Forwarded-Encrypted: i=1; AJvYcCUNoY0guyPxWjp5VA3iUczP12b4oHCZWbG4GwUFA631n2YAYtVa739xE3g4y/i0yplM8Vme5mI2rs8o4NAwiv/hhPxZYlwOrh7vaHmw9sUtpOry
X-Gm-Message-State: AOJu0YxlUzbFU5XKVIdyi4AyHFbYft7EPoqL6D1891RqoZJ/wXAzaTzW
	/CsZOcdXn6CJPJaQqDXeBet6q60K8/o8a8ylq9ZrkR0TgNStg7Kbb1LmxGSZYrDmy0/dSTg1jpZ
	1sgCGvqZWtj6wIHIcHE7VQR5JLAxqLfGmsAM=
X-Google-Smtp-Source: AGHT+IHDU8ss1nc317vIe2fyNJOwpxsq9qAqH9/zotSaIpik4JcCY87vNSLPwSCr4vV4re+EvLAuOJ0Jy254SowvUGM=
X-Received: by 2002:a19:8c0d:0:b0:52c:af5f:8535 with SMTP id
 2adb3069b0e04-52ccaa5a8cbmr3226753e87.18.1718900300382; Thu, 20 Jun 2024
 09:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618093656.1944210-1-takayas@chromium.org> <ZnNHvwV7tDlSFx8Y@casper.infradead.org>
In-Reply-To: <ZnNHvwV7tDlSFx8Y@casper.infradead.org>
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 21 Jun 2024 01:18:08 +0900
Message-ID: <CAH9xa6et8XGg9Et1X6K2o3vFF1WhAQQZqiPmTtf+BKfykSV_EQ@mail.gmail.com>
Subject: Re: [PATCH] filemap: add trace events for get_pages, map_pages, and fault
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Junichi Uekawa <uekawa@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Thank you Matthew for taking a look at this!
I fix both points and send a V2 patch.

> This needs to be cast to an loff_t before shifting.

I found that this applies to add_to_page_cache and delete_from_page_cache, too.
I could fix them too, but I didn't since it will change the max value
of those traces from %lu to %lld on 32 bit environments, which would
be a breaking change. However, let me know if you think we should fix
existing events as well.
