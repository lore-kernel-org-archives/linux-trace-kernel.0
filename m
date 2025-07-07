Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B86881E;
	Mon,  7 Jul 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902345; cv=none; b=OsdxWoWQ5lM5H4HrhkeMsC5t+ISCaEYARJsPjDXlQKLtQRmiy/pnwaH/uvEhoGAVdjg3d/QwDBN71P6HzovOURQO7+1d8+BzEyBM7F5HlGKBjvEbNr+fMbABr1lQYSAvMjSx6otBdi1FJXUVg81NrKPqSlo0MAxfqPJjCwsEI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902345; c=relaxed/simple;
	bh=3cUG4Qr+IPNv64Z1EWnT8TrT8XUMf+AT0Rh3TTHODsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xd+HNwqgbGicqZ4n+ZIZx8D/kRTX1mbzH1xa83zSCTXn1dsuoUboK4UI0f8vetGpdftM0lUzlj6Vr9hg63+3n4rVtNyaE93PormHk99K5wlir4fXST+o+qZ+Gz4qnp5NzZ6dq1rV54heJc8otp60GOJuBZuV9fnY0kpVPSXJpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFqYy9Uf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFqYy9Uf"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70a57a8ffc3so26392537b3.0;
        Mon, 07 Jul 2025 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751902343; x=1752507143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2RtvBnwq2IfJ0CHGCYGxVehGv3P86Mh/6/45Jb+Dlk=;
        b=NFqYy9Ufp9r8b/81rzU6jaUinDICszmIl43b6vk7Zt/6aYTAm5Kk0QCMytJUD23feT
         cEl0Vi+W8aJPOWpH/ff1b6K1RpVvUzad0kV+jIRarYyHvQ8t7Uoe9LCLJYhGhBTspwf4
         IvYZrLEeF6MWjA+MMJ9Jj/ni0mvzeERqFOHoR4dw9X9zcdgejqJuhGaOWth3vPcy4yG6
         vlOJ9gxGWLkKLQ9BuRzHHrYP1Q9K8qk7bLHAlE4ydmo7ZtjVlGRjV/owWbnH1xzthdRL
         QqMFXe24FgJHzy9es7alLxYO5k+8qCXW+NX/BaeuZ0GLTlmaZodpDENxxGFDgmaG33dY
         l6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902343; x=1752507143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2RtvBnwq2IfJ0CHGCYGxVehGv3P86Mh/6/45Jb+Dlk=;
        b=ItNyiISUxhcZjU1kOyTCDG6jWhoTZzmtHUj8MrLcYZ5addBuxpobOqKQs40DZTDb4k
         o/a0KwN0DLtsRUySonfrSJ803u4FjRghocO4mzgzigSlMR9hhXY7hvIUVjNcrqOKUucw
         iFstgX79DawDqvs8K2VlDy2mL64oGNsPH243rTOPiumc/WHMfbemtCHMh7OiSH1eSybS
         HuGG1Dec/kpmrzOIJ3cPOAYEmKY+NwaG+O7AF9sJlaiAH3xbc3pULX83wwU22SyXCrP9
         N/GyE4hYLa7I1z8gOsJEiorNX78riCg9aVDoCCim6440UhqYvSTMZoEJDsybed7wIbjZ
         YQNA==
X-Forwarded-Encrypted: i=1; AJvYcCU2jRaTPDmeNcva1ff0c/tR3WkaXhMW7JBze6fK9fTdLeQtDwGtaMGX7gX/9lXQ3ObzXcYDijHB5z+MjwVMru61T5rP@vger.kernel.org, AJvYcCVlYP0eNL49su6VP4KaALH5/JWkdsJcHbioiRsYgQmkHtbARABoyMxnYRj3SjlY01Suka+e+Oibp3R0Trc=@vger.kernel.org, AJvYcCXkkJ7ANtTsMZN1kjE7OkAX9KZev3MXp4EoZ+bG82QoDgz1NBpkGDSI5t7zbHlmnPD72+jtsbwV2DcFPq0vrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJrPxlINjT8/ntCMwSmfp5g0aGstvu+F5BKVnCCgyG8Lv3Mkz
	wDzywq7wpf68o/C0hfYA0oVSs0yPM3RlniWGB8t+bZs7j+sE5KrSA7PPbEqei2rAisd4gjj/wei
	tjaIeXZO+9kIzsoR3l3y+D6gMjom/atw=
X-Gm-Gg: ASbGncsDCjkFwhUBOKXY4okQ1o+ydq3HJ+YKSy34c2IZ9MTuDeRUlPlEqSWTRxXJcHQ
	h7j1UYRn9ZiRcyHVmeuz0p1yT/7026Cx4GpDV2yBgWHf16Ftr6UuhjbESW+4ls1nOxFANpAIgKm
	AGxO2crZXXpNkVkqofjr3YYu7KPz9XLcrv1W7NZd0MEBhPiokcpAc5FIdibCe3d1XqBC3iHEm3N
	Dha
X-Google-Smtp-Source: AGHT+IHobRt0IVZ9y2H5aHieKxZBuZ9kYKxX7bRopQYtEGb00kgxf2fb/BJfcAAzEetydaLae4Xw+yKZZLvrXk3th6Q=
X-Received: by 2002:a05:690c:6911:b0:70e:2a0c:bc5 with SMTP id
 00721157ae682-7176ccf0b4amr110470747b3.38.1751902342763; Mon, 07 Jul 2025
 08:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704134943.3524829-1-rppt@kernel.org> <20250704134943.3524829-4-rppt@kernel.org>
In-Reply-To: <20250704134943.3524829-4-rppt@kernel.org>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Mon, 7 Jul 2025 17:32:11 +0200
X-Gm-Features: Ac12FXyaAajnDBmF1qqrRhSguxWKBF3vJJ9uNxcN4-zDud7xknCeyy1uyLlWfCY
Message-ID: <CAKQ1sVN9KZYt=M5cst+BonDMVL_wO3sbhgZ+JPzc=Rw9Qfz9tw@mail.gmail.com>
Subject: Re: [PATCH 3/8] execmem: rework execmem_cache_free()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Daniel Gomez <da.gomez@samsung.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 3:54=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
> +
> +static void execmem_cache_free_slow(struct work_struct *work)
> +{
> +       struct maple_tree *busy_areas =3D &execmem_cache.busy_areas;
> +       MA_STATE(mas, busy_areas, 0, ULONG_MAX);
> +       void *area;
> +
> +       guard(mutex)(&execmem_cache.mutex);
> +
> +       if (!execmem_cache.pending_free_cnt)
> +               return;
> +
> +       mas_for_each(&mas, area, ULONG_MAX) {
> +               if (!is_pending_free(area))
> +                       continue;
> +
> +               pending_free_clear(area);

Probably:
                  area =3D pending_free_clear(area);
?

> +               if (__execmem_cache_free(&mas, area, GFP_KERNEL))
> +                       continue;
> +
> +               execmem_cache.pending_free_cnt--;
> +       }
> +
> +       if (execmem_cache.pending_free_cnt)
> +               schedule_delayed_work(&execmem_cache_free_work, FREE_DELA=
Y);
> +       else
> +               schedule_work(&execmem_cache_clean_work);
> +}


Regards;
Yann.
