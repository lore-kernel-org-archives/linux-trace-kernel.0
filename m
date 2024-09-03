Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D81D5CCA
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390779; cv=none; b=iHn0FPz674GWr88T6j8ViO1NT9c+1eIgAbLv5CgDnXZpYYySCBx7YDbBlyTATnuvbV4YcAGkBW5AoCZNxi9JZuesUlxQox9mrFNTgvmy8uYIRNLzNW1oJkiZpHOJRkVKegj4zp8zcTxRhVmCITzsephcDz/wzDN45ZCbCp8985Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390779; c=relaxed/simple;
	bh=CvaDCnV+QaG24AvL/P+QY+StDOYTi5CE3AZLUYyMlzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fStUybghiXps1jHTaPSPa5tDaHfcd5UoSJp2qWqtJ7G+B4H68wLJOQNXrwJbvInEcbwXm0cNQSWz0yzDaqTNvaviE4Z9KdVbqrP4VZwPj6suiRhiNNZVTm1pc91LwhC/XDBoA3oYpvUzpOvSbOGksvW1JZSZvGzZ5RWN9aUQaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I+NEIhu+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I+NEIhu+"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53343bf5eddso7511876e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725390775; x=1725995575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRYQuA2IuhmwnyrQ8YBT5Ts6fvjQ9S9+/c3CTINRklQ=;
        b=I+NEIhu+JgoSM2/QwcWu3DmJ0DCdiOKPHph3GsW7bkDJ7H2wUNiG1rWofPcDT35+kc
         CIa03IVXSpqrW12wkPSm7sXIjc8mBa+cL1y4FSSYTmqIqo8izwqr+jAKiTYb7Ncqo+GF
         wZQ23qEZdjmTSK7G4whw1qw1AbBKF7bZPEmFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390775; x=1725995575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRYQuA2IuhmwnyrQ8YBT5Ts6fvjQ9S9+/c3CTINRklQ=;
        b=YiQpuNXqaClIt8W7ca6NgKTJhY/x5IJgbFHFsBcgvp1qCtOrvSPhXl7oPx0N9ctF2y
         YtJVWnZD+LLq06Vtxy8GEqIaBEVIIe9GFsTls8n7wnNh6mTsKpu8UpRha1vRdhkKmKb9
         buvKyeDWKj1c2Mt/Fj5xBaJ+NialAW4Zkcwehx4g2mVsUSg6Mda8cDOhoI0/ADdUxwUh
         KNmSlYjBgvXOTZj9RZSMs5LF3T6OLgO3FLEcMnxW3laig9tOlFvH1csg6oS8duTcdX7k
         frKUp9Dl5Ju17JOBNNn75/rwVyANnw7vTK9GfcHPP00l00/rc2srq+zO+WHyifLMUR43
         PE0A==
X-Forwarded-Encrypted: i=1; AJvYcCXX2IIXbZKD4+aS92h1UYWCdvOaWrZvuy7uvtBK/pzckux0RWyOI+W3mnoA+sge571AQR2QTbRYydIb7ifTtbHesps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIduAQg5E+P8hxlP1MIgeBCLHD52w79gee3pvQN2dLAIs0V6Y
	yALkbsBdsXxSRrZQ4Zy7wRZg2bLZKAt/C7cXg9H+YXknHhd0SZD8AeGxZdeEU2WTSsdSdhtPUT1
	PDgqWkA==
X-Google-Smtp-Source: AGHT+IGbrptncIOSnU5MAZsQygQ9s/DzBA6+WVJLaVeSg7WcpkfpxOJ2xDXyGGGgFV73X11jUsfYFA==
X-Received: by 2002:a05:6512:3e26:b0:533:43bf:565d with SMTP id 2adb3069b0e04-53546b45292mr10375522e87.27.1725390774245;
        Tue, 03 Sep 2024 12:12:54 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354085963bsm2113867e87.304.2024.09.03.12.12.52
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:12:52 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334c4d6829so7232003e87.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:12:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3RB2g3QHymSD2TiKfEv3ltaVdiWat4HAsLKcuZdMAva1QicVnOYbQWE5TgU09Z6Ck4vckCigFn7eJVuc7zkzfyxU=@vger.kernel.org
X-Received: by 2002:a05:6512:3a8a:b0:530:c1fb:5192 with SMTP id
 2adb3069b0e04-53546b335b3mr10741607e87.16.1725390772215; Tue, 03 Sep 2024
 12:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com> <20240903090843.GA17936@redhat.com>
In-Reply-To: <20240903090843.GA17936@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 12:12:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Message-ID: <CAHk-=wi=qJr4r2DTLDMDh=ryK-x9sciGEeL+ZaWExpiHGyPhiQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 02:09, Oleg Nesterov <oleg@redhat.com> wrote:
>
> but with or without this fix __create_xol_area() also needs
>
>         area->xol_mapping.mremap = NULL;

I think the whole thing needs to be zeroed out.

It was always horribly buggy. The close thing just made it more
*obviously* buggy, because closing a vma is a lot more common than
mremap'ing it.

Either use kzalloc(), or do a proper initializer something like this:

-       area->xol_mapping.name = "[uprobes]";
-       area->xol_mapping.fault = NULL;
-       area->xol_mapping.pages = area->pages;
+       area->xol_mapping = (struct vm_special_mapping) {
+               .name = "[uprobes]",
+               .pages = area->pages,
+               .close = uprobe_clear_state,
+       };

which should initialize the struct vm_special_mapping fully.

                     Linus
