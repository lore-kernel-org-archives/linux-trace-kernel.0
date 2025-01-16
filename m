Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC6190477
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054056; cv=none; b=gBI74j321jumH9qWoF0RlyGWe5BlMeLV3VCoUo7OLpQTAsbRImNaC/BpUoQKxEJma6eOdgX4BfvU8d+i+YUtPr4BRIlH5ShO7HHVQBeoNkBx2PKNVjm32rQdArqaLlcAvWwVNaOy9aB+gMhuAix8WOiPLkEKJa2EJTKc+Qipj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054056; c=relaxed/simple;
	bh=crPe6L9PC/tqgQXgUXhf+Q+KNG3odeSdt+dpPMx15CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueubT541vIySESYLzRvErNfzGN8w+n+esX4ppCrBVeqpTag7oF4fFPWa6QpHUo0S3/PiGiQSp7il5i+caa55ep1Kbfual4m+SzSL7WgsOBPGf2TQN/ZeTk1Z7iSydjovFD6AZ48W5o4qKafGp/AFOYIwJ0UOhBLJj6fWTlYhSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ns5Wku2f; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ns5Wku2f"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so2646125a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737054039; x=1737658839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9C+G173FQhI1bxqB+XXDtj4qeOsuE8EKfsvfarbU/I=;
        b=Ns5Wku2f6HlFsl5pDvKRQhOnL9JMAstit9bAByi2prDSjK9Cv2Zf9UHjnznYb8VaKs
         ZvenycrVHBOkZR5M/Y5MQDCpCAqtPqnDn2UHgXySO1ID205VJAC+xDdPxqu8rzTjpNGa
         bHxFX0iGmEwWHavj5t5GGvrfOWfpSIVb4jZ9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737054039; x=1737658839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9C+G173FQhI1bxqB+XXDtj4qeOsuE8EKfsvfarbU/I=;
        b=g36Y6iMS1rJflXErBybDkr9Ei97kgnwgK0+BgymTL6wsdgTE/NCr1aXxsxxBJre9fZ
         bcKFhCVKEh0tRMRQLHZKhZE5bceMHm7n4SeSKELpWpJuycUJAHiBsXpOWWZt0DGN9nw1
         kAm4jZauL6aryIhTwL5lVEjtR2vYvpshVt9EG0J8AAikMlfwIMYO2tLi8ex9R8ZioVcA
         43Ip2u9BIVIh5OofhCn3GnbLDdoK0u+JnmBc2U7UzgDUIPZYCCAJJyyb9r06bzXbQdGU
         UicQbJHWmAUyzQoJ2TzvF3L6ERZ8ms4x1g9rbrZvZ2aH3/xqTJp/qRrDf3TFZKgxWwSA
         n57Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLeDrvhMnAtPklp6HD6I36EB+YdFwZS1YCzzxgXDIFjfgovB/OfVjh6e3ZZ/qm6GDzSOUUMjtNmkExCdvzKDzoc2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrfYI87bLd0pXpYA5Ep/wCCVFnzsZJP5TRhmLuvKinYkZLFDf
	okCR9PH79bVLJ4UY8sX0zTQjs5fD6NmSq4AVIBexZKyvodQfWQ/AKqthfp7C3H5ukGeLm0i0HBM
	uZKs=
X-Gm-Gg: ASbGncvJdL4ZRHiwMFbDEFzHRSEm5jcIX3/ISt4yU1B0YT2x0G/ksLrpyY/MrjCD+uP
	Kze8+PsiwwJgtgEheUgkzvyCPZaNUJtajqcHN7ctOSWcnzKdVid4VOUuVwGHlnIk7N2BD/CDWHb
	ZO259yofroP9CqO17y8j2fsX+0S369w7zt7Y46ab0gnWspNPIx1Sbyg5K9dJCU0P11Rcs1D0Paz
	0N323MQW0Y3wQSdPFlJdHXFILDkkbmte/4VjMQVRE6BpHAiuTeB0KhGF6+d0UqE9C9++fhVmySB
	+vXAorwA/yBnq3kuEkbhGq6xAsVYhNw=
X-Google-Smtp-Source: AGHT+IEABmOR42M02uOpmw6DS+dGKd/uvwVBCdMO5E7otOtsDdOg5BZAHnf8ESqPguTpSiV2F87eEg==
X-Received: by 2002:a17:907:d87:b0:aa6:519c:ef9a with SMTP id a640c23a62f3a-ab2ab70ac8cmr3483752166b.53.1737054039318;
        Thu, 16 Jan 2025 11:00:39 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce1eccsm36101666b.59.2025.01.16.11.00.36
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 11:00:36 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d9f0a6adb4so2678880a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 11:00:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpCCYLXyG7xWPZeZJtX+Pyl2tNmn8cc5vXVEfniLHzqW8Je2grjRF57f6pGcZZiol9QFtrGDFocMxQuDZ2gXCIeNk=@vger.kernel.org
X-Received: by 2002:a17:906:7311:b0:a9a:bbcc:5092 with SMTP id
 a640c23a62f3a-ab2ab6bfb7amr3215368366b.39.1737054036177; Thu, 16 Jan 2025
 11:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116132359.1f20cdec@gandalf.local.home>
In-Reply-To: <20250116132359.1f20cdec@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Jan 2025 11:00:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
X-Gm-Features: AbW1kvZhAEAPFdLu_XCSUkgL9bv7yhhorVSJTllTKCEW113vDKNfW_1s1Mdp5pY
Message-ID: <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 10:23, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h

No - please do these somewhere else.

This header is included by *everything*.

Put it in some tracing header that isn't.

             Linus
