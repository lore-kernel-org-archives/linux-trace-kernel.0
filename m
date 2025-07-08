Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DED2E339D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989958; cv=none; b=tSzqhQMcuHQR/e6y2DexFZjZLgQSTPwnALpJkqjBo/w1YM1oMD9e3IX4QU1rU0QR9Vx34HrnLlplrZWIvvVhC1RkM+U6/rU0BIk0Oqg5ynYyHu4EpNgDW1CBGI+/cknJM6mPKYzYFpnVHHzVj9UOA840cdHRKwmC3O0K0sjnAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989958; c=relaxed/simple;
	bh=VB4DKDbnFxxhgT4wajWqmZ83svuBw+tft3pDkE9FqT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yp0FKAKE3LhG08CONV4ApgcRtdtVQilekT48dpNurKgvYjlieMuI9i+QKTyVPCg6AH2y5ytwNSqcxKzb7V7Ssw3wdJ+QH0ROKUhfdH+O5WU9A30ak08oP2ZvF+EZvYOXrHYaErBqz3GCUGBQkaB3mbFVBztSVfKg9GV7WSFfyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Af990yjW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Af990yjW"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so797901566b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751989954; x=1752594754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e1jzCZfbh+UOZgumo9HhTaPJort8G39J3Qx1CDHd6zY=;
        b=Af990yjWdUtKgeDM6qgEQuHhgfzmL7G3v2uLEMxhqK4HvvaU3K1DRwnudMFD4qePiG
         mWSbFqNJ8VMzN70DE2286Qv7PyE0Txpzn8XNHziHo5c5QSPuMQkSIdvOGtU61AcN7gpl
         9Pdt/LqRYDtdMfJx4u4l3a79ihSadDLp1+ZdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989954; x=1752594754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1jzCZfbh+UOZgumo9HhTaPJort8G39J3Qx1CDHd6zY=;
        b=jqxSK960ELHFfCR5gQI+eux8UP8Ju0HXY3/iIJxXWNWOdIwDR1OZ00K8frgRxY9RMF
         rcLItX6wpSUeWOzISdKw5hG4rrz2ejYsfF/OUgrRU6LyYqPPETt0vPTRmOfDH1+YprI/
         FORhHTgLIyN2a5g78Kzjyhj5nHWj3SNLcPPERFD+4pCZeqFS+lAnAs6f5aTYEUiapShq
         pih/IepDoJ7mVWi++9vd9xrlPOAbMBwkeqTXvuE1qmYVPF0NKrAj3HTngdyLFQY7YFJZ
         uH8yOAJFh1wTNHXyeOeTs5o++gPQZdA3myJSMSCAiQuddjKvXgWOqXrQhKwKwqPsGtGp
         8nRA==
X-Forwarded-Encrypted: i=1; AJvYcCWbjtKItTFyj3NDEu91zDsI2SGZtVgheXqBL2dsHVKECbr533pll+o6bacVkfD6BUZvxPp9OlQorbipF0DWIMdqFiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGO63XzI9mRAN9JhIfCqZFzc0BN6LOqFa1mSDOVgp5/5ih4xJS
	+OYp3HgBK6xmgP4zlO7xRyYFWXbK7iDsEHp6OD9hBxuTQY/DijpypSFBq3pPP5u5wVxF2RXa6vK
	LkcsPRZ7ang==
X-Gm-Gg: ASbGncvT+BHfwhME7usFY+m439TMvZscS69Fr7Fe6EygooaXOcOCA/Zw/0IiUWzHwAn
	6YbiNohjb+gjpSkCBDQBc7Z0BNISGOmYMGqoIGmhXdPrSKhP9K9PH/a0Xplqmsri8hXZYK+8dhY
	IDSnRr2brxTjQKWl1REL1/geQ15ck7ol0V2Ix4K6TiHAxBE6iB1Nuu9VrWddtT4wR7Ku8FG2luN
	2FzxVMFEwbgEI8AhobCgZdo0juUtKCRSht3F2IzO0cofLTF/DtUH+wS+w84VCFYZBCR1lt0hTFN
	0GB1uUNOZcLEFUyAmge+DjNVtAc8IY4KW5V4ErMd/Yph4GR8s5vwQnct0Z7YRh8/jlSF2G9yh+9
	FDob/6YJOLxq3iXWWRUQVybuCbE5dEMH2CRaz
X-Google-Smtp-Source: AGHT+IFmP7BeT99NnXe1Z5zbUToH861xT0mNhJrj8iKkQ8r46lf7B2Kq5Wwp5EKXzpuHSvEKdsKBiQ==
X-Received: by 2002:a17:907:3da1:b0:ad8:914b:7d0b with SMTP id a640c23a62f3a-ae3fe64d49dmr1655462266b.11.1751989954425;
        Tue, 08 Jul 2025 08:52:34 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae410916f12sm674262966b.47.2025.07.08.08.52.34
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:52:34 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso7391569a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:52:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbO7jt+Q+4lHkkR02JeQ12UkmKBPBq1/9KYD5BuFSBJt+yYdf2CVE7a68fGmnL6jFJcClyGR30mOXCLh/fM1GCDUc=@vger.kernel.org
X-Received: by 2002:a05:6402:5191:b0:60b:9f77:e514 with SMTP id
 4fb4d7f45d1cf-60fd6510ce0mr14317873a12.10.1751989953772; Tue, 08 Jul 2025
 08:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
 <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
 <20250708092351.4548c613@gandalf.local.home> <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
In-Reply-To: <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jul 2025 08:52:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOnFbRJ9V81VEeSK+=HuD8ODSq+S3STTh1JwYQLWXXXg@mail.gmail.com>
X-Gm-Features: Ac12FXyovZoowk3cIPdznURFGER3H1uO2rBwoO22YC_nLxVaqUCimxKTzLI7nYw
Message-ID: <CAHk-=wjOnFbRJ9V81VEeSK+=HuD8ODSq+S3STTh1JwYQLWXXXg@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 07:34, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> I had found those debug printks really useful for debugging
> corrupt/missing .sframe data, but yeah, this patch is ridiculously bad.
> Sorry for putting that out into the world ;-)

I suspect that code that is still needs that level of debugging should
just not use the 'unsafe' user access helpers.

They really are meant for "this sequence turns into three CPU
instructions" kind of uses, and the "unsafe" part of the naming was
very much intended to be a "please don't use this unless you are being
very careful and limited" marker.

Now, I do think that the "goto label for exceptions" part of the
unsafe accessors can be very convenient, so maybe we should make
_that_ part of the interface more widely available. IOW, without the
whole user_read_access_begin/user_read_access_end dance?

That model is already used by "__{get,put}_kernel_nofault()", but I
think it's limited to just some unusual code in mm/maccess.c.

             Linus
