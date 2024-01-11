Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D6358125
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3JZ9fE5x"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7cc0d31fd85so1675328241.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705008044; x=1705612844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV8E3GY3Bf8X4jIpwdPtDTsqut4T51x4SGgA0WQsHBg=;
        b=3JZ9fE5xote49FhIjSUNfJ2QyZuZ/cGQ3Msh4at9C73v4YVITT51p7izDtUJmdYThy
         VYtkFeC3C9X/PHgsY9E07ypfDbLz3u99Ig2RrhGn7t0RphOyYOYS8zA/2NSmtxPjfkze
         fk448XSLJldloTM7Yhn9qc7o+nyP6hNeHHhGBdkUNcPAT4etYh//xHSPplHBS5d/8uSM
         ZJ18mXf444jmVgxrQZzLnqAxTOv9ZkmUdfqXtgHWI3cjD+Mlh/85zETulYLzPpgzlVI9
         n6WCJqPTA4tMaby52qXh5tduSuBS1c9p1JiYidCjAm/FCdVFo55V2GIfM9tRSt0T3aBs
         Ikhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705008044; x=1705612844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV8E3GY3Bf8X4jIpwdPtDTsqut4T51x4SGgA0WQsHBg=;
        b=iJVrghfpPH6pVUEaunaKQXVHSBl/9eD08lWZFVrym6KHWEUMWeGBt+e4CgIWZZjzHa
         JvG4y1SNE9OSKKWFCOQw5ufIJ3/5DU6nOS7JFEGLeWikpUJ/3fha72FAOCcDH1eRdHbv
         zjfw5cJOkhU/3ZYGxRY8m2eFmLWr2f7OUXWtlC3F5j2TQLKRxYr0f2UWh8Ro2UShbZcU
         dCDNJbn7w1wBL4ptjlQrxPnQ6ZdURD7ThqDTe7GrP5rOBBdvABja0WISDxtadVPbq4g7
         FQONfVHHmTdtMjk1V9OiA8PGNmKh/Wr4gjsKk5GeIyKB1sLqXZ1WFidPLccBPYpJFVRf
         2Dvg==
X-Gm-Message-State: AOJu0YwADwwMYPD3JKp9MR/fGVpMcZKx2PyWh52w90GVLISaOYEpdyWn
	6Yq1dc3/dl/wIJFf666GDHrNt5nA+0BuFASxtjFK3KOhyJWG
X-Google-Smtp-Source: AGHT+IGD0yFAepkYBqAzxYxiPmzH2nLXLz0AQf5J6Kh1QXElngJUOD9LfOmgQyL5SKVkBz4lh0erKjErSzCLxOG6bbo=
X-Received: by 2002:a67:f2d4:0:b0:468:1083:39ea with SMTP id
 a20-20020a67f2d4000000b00468108339eamr448515vsn.20.1705008043947; Thu, 11 Jan
 2024 13:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111001155.746-1-carlosgalo@google.com> <202401120052.rdFjpivG-lkp@intel.com>
In-Reply-To: <202401120052.rdFjpivG-lkp@intel.com>
From: Carlos Galo <carlosgalo@google.com>
Date: Thu, 11 Jan 2024 13:20:30 -0800
Message-ID: <CABtOLRJ8=fPePsAG1-QyF_uo2X=sOGXcgsU_fJJXk3mFyOVN+w@mail.gmail.com>
Subject: Re: [PATCH] mm: Update mark_victim tracepoints fields
To: kernel test robot <lkp@intel.com>
Cc: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com, 
	oe-kbuild-all@lists.linux.dev, android-mm@google.com, kernel-team@android.com, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 9:08=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Carlos,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 0dd3ee31125508cd67f7e7172247f05b7fd1753a]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-Galo/mm-Upd=
ate-mark_victim-tracepoints-fields/20240111-081635
> base:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
> patch link:    https://lore.kernel.org/r/20240111001155.746-1-carlosgalo%=
40google.com
> patch subject: [PATCH] mm: Update mark_victim tracepoints fields
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/2024011=
2/202401120052.rdFjpivG-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240112/202401120052.rdFjpivG-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401120052.rdFjpivG-lkp=
@intel.com/
>

Sorry, I missed a comma in my final editing.
I posted a V2 here:
https://lore.kernel.org/lkml/20240111210539.636607-1-carlosgalo@google.com/

Thanks,
Carlos

> All errors (new ones prefixed by >>):
>
>    In file included from include/trace/define_trace.h:102,
>                     from include/trace/events/oom.h:206,
>                     from mm/oom_kill.c:54:
>    include/trace/events/oom.h: In function 'trace_raw_output_mark_victim'=
:
> >> include/trace/stages/stage3_trace_output.h:6:17: error: called object =
is not a function or function pointer
>        6 | #define __entry field
>          |                 ^~~~~
>    include/trace/trace_events.h:203:34: note: in definition of macro 'DEC=
LARE_EVENT_CLASS'
>      203 |         trace_event_printf(iter, print);                      =
          \
>          |                                  ^~~~~
>    include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAM=
S'
>       45 |                              PARAMS(print));                  =
 \
>          |                              ^~~~~~
>    include/trace/events/oom.h:74:1: note: in expansion of macro 'TRACE_EV=
ENT'
>       74 | TRACE_EVENT(mark_victim,
>          | ^~~~~~~~~~~
>    include/trace/events/oom.h:93:9: note: in expansion of macro 'TP_print=
k'
>       93 |         TP_printk("pid=3D%d uid=3D%u comm=3D%s oom_score_adj=
=3D%hd",
>          |         ^~~~~~~~~
>    include/trace/events/oom.h:95:17: note: in expansion of macro '__entry=
'
>       95 |                 __entry->uid
>          |                 ^~~~~~~
> >> include/trace/trace_events.h:203:39: error: expected expression before=
 ')' token
>      203 |         trace_event_printf(iter, print);                      =
          \
>          |                                       ^
>    include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLAR=
E_EVENT_CLASS'
>       40 |         DECLARE_EVENT_CLASS(name,                             =
 \
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/trace/events/oom.h:74:1: note: in expansion of macro 'TRACE_EV=
ENT'
>       74 | TRACE_EVENT(mark_victim,
>          | ^~~~~~~~~~~
>
>
> vim +6 include/trace/stages/stage3_trace_output.h
>
> af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Goog=
le  2022-03-03  4)
> af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Goog=
le  2022-03-03  5) #undef __entry
> af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Goog=
le  2022-03-03 @6) #define __entry field
> af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Goog=
le  2022-03-03  7)
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
