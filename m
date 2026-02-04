Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F02BEFED
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233133; cv=pass; b=IEDyql8oRXmAa2QtKScDPfZ33TI1xQAnhRZanPBf8X+a6Np4O9spj4b+yoR1NTQynvcafBSFbGmX/iLM/wOOBddR1NZRLNe5Rl2Ogg4KLABcLqZPCGLrVx7aerxutgebHpIkb90fK7GhPf1jz3uGSttIs/PoRTF+Rbb2p+SSsEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233133; c=relaxed/simple;
	bh=nhyvLQ+Bk0bui58qEVDPyIISYlNiBeaFY239O0EUQIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVKjjjvlNrh+HhRqxjvmzFzlIkZe3kx7PfuAvGyIogGoliOTENt/KG5DBOM/NAMzOgAwZHOaXJsh7FI6pgyn8KkLRAZuj5Bqut28aWO5app7hFY6qTluS+WJj1S7V/Z9KkoRqlcu5P2xJtBmTHZ8sxZ2xlsY5nRErhyzQlPHbRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c/kWkhaM; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/kWkhaM"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so55651cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 11:25:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770233132; cv=none;
        d=google.com; s=arc-20240605;
        b=IG4HV4o5FDBqJwoj0W931z5zx5TeumGqNvREApHwVyiptAs3sY3f7AXnxoKZuzVUDg
         lZGfbkUiWasUONmVTzFHu+BXrE9AO6aTpBX6Et1AfFAi5FxWhTiBq9xFI9gDUYyMXnLn
         mVYlsPTNKWwmEATJ4v+8Jkk4cUlKDUftO8hPqBmyPrFA2QeZzmDxJ2N4puX3nDbiYv72
         00pdKMBPi0M0c4ePo8V8uv2aEP178071tqviCWfhftnb5QNz8jW/7qzmtaczRWZMy7bb
         hk1TOrBJVj9/zd0rfLz5npwqhIjigTElLEKfqZ3mjT9OvV8R140edUDKqX7Xm77dRAvu
         8teQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nhyvLQ+Bk0bui58qEVDPyIISYlNiBeaFY239O0EUQIg=;
        fh=E8BZXfWwmniMCkQXf8UjDlqsB1jNVz8J/rRR2T1BqFA=;
        b=HpWfeshma+mqlKqu39S43+aZ+P1U+RPR/pwYwX9bPT7+jRmku++FWSxZo0AmP5I6iq
         +nCtCDMbKjNBkjUXl69WS1xas6hAh7fW9hMp8BOy6t2LB6mgWlNGPyJ0zNpfrS+ObwCn
         aKxyBJ1w5efruDaDJIauStrYdpJj+bTS+wqz9rD8ywFnCFHVxgpE4r2nSXapDnhR0FjQ
         ZqW3Pd0XR3SWPziBm1hGcWJsy04bYGiJpUXh4+3BD6J06/LPmVZC5mUcq950aCGO4jbj
         Pa1sDhLsGt3uGmFWs4+cIe9aotF1eftqrL3Q/+8/VyUBkCtedRMC912p3PcFk34TyWFD
         iIMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770233132; x=1770837932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nhyvLQ+Bk0bui58qEVDPyIISYlNiBeaFY239O0EUQIg=;
        b=c/kWkhaMFCWueD9B76TjimG4hPcb7kzIe2ZHOlATaPBNBfqTOBKod8agR/A31FKC/D
         Pq8WjJ/EPx/D+vnHXHCmxmnpLR8j5mcuacnzdf4KkH7qxCk/riQ6ifpFW8lK6vp9P2DK
         ux2GpLXoTmvoQtnqa8EPVd59ZRLl17ygdTTvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770233132; x=1770837932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhyvLQ+Bk0bui58qEVDPyIISYlNiBeaFY239O0EUQIg=;
        b=hAtn3PmvqdBXdrUo0tzDf7wcOXn3hZ5f59bu+fN6kpuJmdvo4R6qx+Kz/ygyag3jSb
         Fp2zQ3Hm9oCTkZlapUFrtzSRyYS10jMrWJRIDPDO3WJgv6m1sv01NH5KeXMg1U3uZneO
         BWHpngxsnGrW+URQBxpsRGTQMqEUjN/83ZzVXd6vFHsNcJunSFIkFyDchWUXlp570TSN
         xpr5LmqRCq/PIii0OrtudpdRCg7hYKjfgVw5YPT2/YWHvalMOBZboAJ+uuw3vXsH/7Ts
         Okoi8ag5EGH+H0G5noFoEBwSMrNlQCk+NYFDXt1KQSBgpNfZVUW0m0o4JkUASqShvFOm
         mZTg==
X-Forwarded-Encrypted: i=1; AJvYcCWJyqo8jaLktnuSHeTxymiOAhrBq41qXS73R53nMyT05ToIAvgJ9fJckUTy1O02Yd5Z7Vrz9HPbVT9olrVCL3IYHLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnitbOsJdVekpk0y51KU93MG7juMvS3tsqYH3HII5wDrcfxE9x
	vEDcQDsuoQz4lAHhSGt/E78R9nGZeEcdWw5LDH0xro+SWt4aILkjGmh0m1KPKgpKc4KdyFG+wIy
	rXQJhN/+0weQwzZuy22aYSHZLEf/OPdYOh9UlZ/7URsVqW/78SEJ9KQ==
X-Gm-Gg: AZuq6aI+9lHkNFiT2LhM3jHZ5WKSKMon/u6aa8FZy0I1FXRG3JnJJeYwplZiwjfv8ny
	kC0RfxetRYFnU7TLabOyri51JJ8jKSaM2RYA8BqWXPIZcmilsj4UZdtu8lh7EwqIRiuMGeF1f9t
	N/iFlKRUS5wDIAWKkvO4K3AFqJ9gSMayQzfE/ICEIr2lGP2U3cbfEllPfX+5BT1ztnI+qtxSFZD
	pjLmCcsS+2ckStDQQ5NfeVUnmxbnb2izJmSWPyuvF2IOm0Hj15wche1OnqQsKhoUQu8sbo=
X-Received: by 2002:ac8:58cc:0:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-5062b25de71mr1131741cf.17.1770233132046; Wed, 04 Feb 2026
 11:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177019401833.80694.554894321526842218.stgit@devnote2> <177019402883.80694.10977484286951965499.stgit@devnote2>
In-Reply-To: <177019402883.80694.10977484286951965499.stgit@devnote2>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 4 Feb 2026 11:25:19 -0800
X-Gm-Features: AZwV_Qg7k1iCDHhT_3WfDmzMlrEEx46unN3gO45HX3hLUsndnV_6n1i0hDIE9UM
Message-ID: <CAODwPW9sCyFS85RHangjZ=0aY8d8Og8A0FGycP_uQ_wcCaYJuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bootconfig: Terminate value search if it hits a newline
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Julius Werner <jwerner@chromium.org>

Thank you!
