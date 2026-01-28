Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA93242CF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621040; cv=pass; b=cv7dk9gyCmZmUAvMMyHCcEkitrH+Bl734pPcI1vpBO0T6sCirlUKeAw5tZcN2SYcb3N95KnpjT6WDrNHACKgVqTnSGiLdHvK7wdb38CwIMmjNf/DUxErTRTCNZj4Lat7osACMjbB1CbIlXJxljJKYFitUdfQQkiVoDIB511bIYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621040; c=relaxed/simple;
	bh=kizkZuvdxw6uKJdz5CGeib2vOGGoPb1DUKZR/ygQBzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+NBlMNPEk2QeoeOOy85JaIGAih/2MBUUKAu62zHBYDQn3UAy4RS/SioD47WIFh2BYimzcgaRjzolNS26RPXU/JwVspOOeDZeq4IJ5b3jH2/frhYwhpCwLKn+LPoHdO3t9eDy7Aujd1Ia51OWY0Vlu9HKlMprVEVN8rngn92JMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLRINZ9Z; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLRINZ9Z"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso23525a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 09:23:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769621039; cv=none;
        d=google.com; s=arc-20240605;
        b=O1UaXIa0IhgnnTmhjGipJ2PSdDxGIzxHKh9e5woPO7Yq6uUp/RqCSqDxT/j/mHbKrj
         BoPu5yCJ0/GLp6hgldHaV2LBdFriXtMROxUqxNYH9l/AM2BVDCFe42Bi5wZRFH3N2pZz
         hmM4qLN++umVWexm3aS0TfHvD/rVMWuFTTcMtgUoXs+FalTkLkiiKrZOdcI3PqrlIweJ
         3p+m8kJxL1YI5D24b679+9hGq3hx0FgDG/HZedNbltpNQftNzonvc976zupvOQ47ajt+
         /FESXQ6qs4xYbg8S+2xeuHBiS6EeVnJIF46UseVMX6RKU2kxPfgvZqAnxupOCU8BtXEG
         pA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        fh=L0SxfzCi2z2N7sU6TX6Tl4eJua3+hfYI2XvtRw70BEE=;
        b=DUj7KJJIidnzt+3eFexS2oZ7aFY02pnSd9ISszC39mShyDN1fQIjoKdzxfolDPl84U
         YRssWh0T3M9f75KTvPWD4uaDQOenLHxjNZ5vGw4vB4P8MRNLmhlQ0EZqv/oas1eNl6kz
         uP/lOBOcQNBAilgDJ0CVEpAKg6qMSPR4LxpcxiwMoL/HEy1tJNjWzSkb9jArGNhBzdjH
         fwHeXDAHkv2Img6r2dGdFJ0hcw/84D2ueH1O0BatC8sbZpnfcXQ64aaAOd05PzaKEYYk
         Ov929KFPocWPXlaimwYMt6YuL55YAgXc2mxvACXNOJFXes9SzhYEm7HAv73xphWJGKGR
         PaJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769621039; x=1770225839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        b=RLRINZ9Z2mdC15RRQfK11I3dIYlKrJQt++jxEjPb5IUjwEYbqGwXI9TdsrC7Os1JLi
         zee3W3QMflyxCOu4sX4hcppUhInbgwXpQRjqbQy/QbsBTKJ1+oEAA6IldwpwN6qXZNfM
         aqPsoyMOTzd2LCGriFaZukmwgRRBLOlLWbtK5Uk4aWuxaipK9C7HTTGM1O6jLEcVzu2P
         a5UsxiFeCNBSVvYP5GkFcYIGQIFuGBKMsF+i4JBi/abCd9ZCRYmTODfFHUZ3Cq9SSMk+
         Y976E+Zzcp74NphQd/ssDhWrhz/IRAWOR78SwW0a7A6fvm+2jX8gFInJ+0rmCPkv5q3+
         RRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769621039; x=1770225839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HyWyPzTGB/cOBYn0NBzbfLp7xlXZid+2WFTQZJ9u/mY=;
        b=I9bzEQxbiz7bWNNh3ObfSP0HOqkz3I/wrzEgD8cA02mx/6PlCaRhYHZS/ouzGXCrAp
         VyLi7pJZg9Ygm5nTDQw67x5aMwCnC8p7XUzMNk0KcxAi+rIqWH9RyFhY3iyG/OJnk6Pi
         q6MnJd8qaQDxn0efVZpv0e1l0cvpLXkU1tUud5r+4rvra7baOBjfnX4WEOXqJEp4r+9T
         GV7ONpbeQVgVsSHSMEWXgZZxtzGnoUKK1XjNvn9cUsLrhjKm55XXQBm9KoGbe5Yzl06Z
         2vOwj5zPyLgX2lR3R5XC8EANG8VYqiGnEvkLP+y1keT1t8PXoGJ30RdxBjBalOB2WiJw
         fkdw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4/DnNz/tGb7r67VYTtwccxzxtNY1RzRyexNoqQOPX7CugtiVZOWbBva9Il5pV2cd/j/iijGURfo4ZTUCQCj8z3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsxAchPUqOWDPhkxwEkM3AAfHS5KC2v5cpW0dfxAqmYaCfXgh
	/gVGEbsn1dtOoEdbIAa2VMmj7OuSXUZpcUEtE6NkfzOxTnCgxSZt3Ui2YYgQ2S9Nend5/Ar2XIf
	zxyihC0n17IA0c4cds9wvRKG8d9sDrVU=
X-Gm-Gg: AZuq6aJTTABJ/TSChUd92BfyFSBj2HJ8vjz2ttwBbwbrZOlkhonVB2/XLuT1rjE3vL2
	vmxManQ8otsdtSl0bJKQkt7fZKJDwP75QN0HUH6w04DsvcKKZT34eIyIJDQH16ry/d+zPJa0Ro3
	182temdC2B8EPFYzDgsVpZ2MDS8kYV59dbkVJPULyN+5B1lNDyw+B+0wQmoWsZR7Q3h9KpRNP9X
	uxP1cldO9x9RE4jS0ys5wc8taiJq8GD/C9bv7FGSfjYa+9sH945OeizIeFPAzEwBhJJIgM0Guig
	HWCA0AT/fCg=
X-Received: by 2002:a17:902:e5c9:b0:2a0:d6d5:b342 with SMTP id
 d9443c01a7336-2a870dcbe7amr57082335ad.37.1769621038802; Wed, 28 Jan 2026
 09:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-uprobe_rcu-v1-1-d41316763799@debian.org> <aXoUOEhDfncEkC-f@redhat.com>
In-Reply-To: <aXoUOEhDfncEkC-f@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 09:23:45 -0800
X-Gm-Features: AZwV_Qj6rb3WoP_Y9fiHuFQxMtZyQOzI2dFswDQeqWIoSEtuJcdiEz7owWd2EyE
Message-ID: <CAEf4BzYJJiUdQTjDgr_uVSQ+uBhYWKki0vjS5VffTzbST1uS2g@mail.gmail.com>
Subject: Re: [PATCH] uprobes: fix incorrect lockdep condition in filter_chain()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 5:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/28, Breno Leitao wrote:
> >
> > The list_for_each_entry_rcu() in filter_chain() uses
> > rcu_read_lock_trace_held() as the lockdep condition, but the function
> > holds consumer_rwsem, not the RCU trace lock.
> >
> > This gives me the following output when running with some locking debug
> > option enabled:
> >
> >   kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section=
!!
> >     filter_chain
> >     register_for_each_vma
> >     uprobe_unregister_nosync
> >     __probe_event_disable
> >
> > Remove the incorrect lockdep condition since the rwsem provides
> > sufficient protection for the list traversal.
>
> I hope Andrii will recheck, but looks obviously correct to me.

yeah, I did, and it also looks obviously correct to me, I didn't need
to use rcu flavor there in the first place, I think.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> > Fixes: 87195a1ee332a ("uprobes: switch to RCU Tasks Trace flavor for be=
tter performance")
>
> This commit just change the __list_check_rcu() condition...
>
> Perhaps
> Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly =
under SRCU protection")
>

yep, this one is the earliest change adding unnecessary rcu flavor of
list_for_each_entry


> makes more sense?
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
