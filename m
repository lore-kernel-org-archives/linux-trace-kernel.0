Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E523B0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747016; cv=none; b=i7/twCMrKi/dJJQXClMDa360oH0y/oV+AMkqeClzzT74PiIU/2x1se2NTTQzi0prB0UchIb0e7WWaleM3OOHzkIj+zxkTWlUhDsyp9cWPYg9DOx7GhN3JiRujoFbx4glhJrFT+afD3f/cSQAgRgcxe4sk2s30+ZVqGzr9GnX280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747016; c=relaxed/simple;
	bh=wRramqrxc3wyAWxpl7hhmu9IRI30Tp2rzVfvYllnaq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVJSPxNKNlp7FffPEQWMxHXllPoWgS9UwGImsLNHoVGoUHYYvQeiasswuKVOVJeMt85x193alOWHQdu29FqYJiKfjJYKaAgJeMJvSAtU5t7G9DiOnjzvitei/G7IcF+OhSyILxaz5qurXJAXicEDC7ypecEjGfSuIsmvYzxeWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gV0cZSVk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gV0cZSVk"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d69771e3eso2158745ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758747014; x=1759351814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yUtonTzH+d6Koc9tBSC0pPXzcPpJLfBt1hfJF5PLabQ=;
        b=gV0cZSVkbD/ukgCAg9Ude8i7WAsHi2+wzvtynBLmrEo2rau3V48sfgrr4JV7OAIh91
         4mObkwew2Z0VIm37QeTVr42c71ZfDQzlyudFKXB1GTumqTP7n/M+pT/cEY4yl22lu51d
         G5AMwAZ9K8MZ6BZvVobQvaJzZ36ZTYOLD+J/XC0u4vd6LFCFI52F/hxGVujE+qpAkwfT
         73Du2YZy/w3ZVFLSeaYp5DhEeRLq+m+nk8rhKhZpyxHTrg4LC7bDjmVAKj0FGxLng643
         mFI+EXrN7dSF4EAN3D4rLLq4Q6HP8z/bZ8zgFCngJ0S0NcYSvQhm1ZbKJoczG1FpjfoT
         PyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758747014; x=1759351814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUtonTzH+d6Koc9tBSC0pPXzcPpJLfBt1hfJF5PLabQ=;
        b=G6/9SeIjW7bLMTcAGsuaJeU8pO5P2rr0HtYv6QxjUYJONZpMh0T5gDifYBk12p4OT2
         cQtg91/v7jkV2cCiEx4UvB6JuEkZnrDhNrnbEU/0qg4zCiozjGzAO/Eb6YFQWko4fBS3
         w8gKmZkSbA5CMqV2Qrbud12yYdrcCKevrz3nASXB004/1q5oVBG3J9ryOaBAi8We34fx
         pmmxGQ9sTLnsNw6ffnsp7QpTUXIxidYN/nx/ZkZ5+ppa5s4b+bW8Vqj70HSUnSylozIr
         YnX+HkwxoSsMQ4Tc8p9yY92eOJSIPCXsyGi3w/TZ8lRn8PCcwH25AtO7SENeM+G/n1k3
         dPNA==
X-Forwarded-Encrypted: i=1; AJvYcCWSZtIQEpuKGvQtBmdbvCmrvk8SshIFQFdac+sarPpYZ6Y8zuY8nF4sdQ0paL5+MU/uJ3B61rDfWBzEbwmSDfy8g+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qAd/FmmwO9GZIApW6CPf14UMxrz40eBZo7PEC5t6NcSpWPbk
	FMX2m5YwD1M6N2UvUeejCTcgzYRTpMG1GQeiN8fr132Qdm4bxaoBZUFmgOT9nNSmibNSSIxonXB
	4r45KPSJtRwHeGNrbeWn/z7QCD1nMNhQMk3A+IeDq
X-Gm-Gg: ASbGncvswxZHWygedftHhZm2/YCq5E2FI4nU2fuBSjf4dnpFPd6/RLMunY/zRElYVgV
	ZsLKwbphqwd1ZKwZQnMZT4s1z5bs4QNl5gV0lmJuhI5k1SxpS+j4e77Fvw9t1XJyqtqAjdTpSSQ
	fzB9n7QwqXQfKcNdqhpjTWrdcUgHHtHOMLCJgxi50Jg5q1hiVXaKCmhYBavuiWpe/CW1QxQ1dCN
	jBk2ON3Aj2RdCVq8oeZETLmojhxsWrSeVDPpcTHd9tPL6TU6efqfKc=
X-Google-Smtp-Source: AGHT+IE38fi+Fg0q1j7Ol0QGEtgHPSQpfsofFwHAAg/Zt4ZhCmzeJrbUHHkyUG+gDW1YXxPVgRa+tkuyDrRHf/9act4=
X-Received: by 2002:a17:903:264b:b0:269:8059:83ab with SMTP id
 d9443c01a7336-27ed4ab545emr6206725ad.51.1758747013201; Wed, 24 Sep 2025
 13:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924115124.194940-1-wangjinchao600@gmail.com> <20250924115124.194940-7-wangjinchao600@gmail.com>
In-Reply-To: <20250924115124.194940-7-wangjinchao600@gmail.com>
From: Marco Elver <elver@google.com>
Date: Wed, 24 Sep 2025 22:49:35 +0200
X-Gm-Features: AS18NWBgUAm60x7jbnTDK3WCQpUXDCFu_1mbN9k4BD6qrp1olQW-5h-0n2U9Y9E
Message-ID: <CANpmjNOuA3q3BweB9kTUpAX4CX1U25Pqa0Hiyt__=7zio81=Uw@mail.gmail.com>
Subject: Re: [PATCH v5 06/23] mm/ksw: add singleton /proc/kstackwatch interface
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>, 
	Naveen N Rao <naveen@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Nam Cao <namcao@linutronix.de>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 13:51, Jinchao Wang <wangjinchao600@gmail.com> wrote:
>
> Provide the /proc/kstackwatch file to read or update the configuration.
> Only a single process can open this file at a time, enforced using atomic
> config_file_busy, to prevent concurrent access.

Why is this in /proc and not debugfs?

> ksw_get_config() exposes the configuration pointer as const.
>
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  mm/kstackwatch/kernel.c      | 77 +++++++++++++++++++++++++++++++++++-
>  mm/kstackwatch/kstackwatch.h |  3 ++
>  2 files changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
> index 3b7009033dd4..4a06ddadd9c7 100644
> --- a/mm/kstackwatch/kernel.c
> +++ b/mm/kstackwatch/kernel.c
> @@ -3,11 +3,15 @@
>
>  #include <linux/kstrtox.h>
>  #include <linux/module.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
>  #include <linux/string.h>
> +#include <linux/uaccess.h>
>
>  #include "kstackwatch.h"
>
>  static struct ksw_config *ksw_config;
> +static atomic_t config_file_busy = ATOMIC_INIT(0);
>
>  struct param_map {
>         const char *name;       /* long name */
> @@ -74,7 +78,7 @@ static int ksw_parse_param(struct ksw_config *config, const char *key,
>   * - sp_offset  |so (u16) : offset from stack pointer at func_offset
>   * - watch_len  |wl (u16) : watch length (1,2,4,8)
>   */
> -static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
> +static int ksw_parse_config(char *buf, struct ksw_config *config)
>  {
>         char *part, *key, *val;
>         int ret;
> @@ -109,18 +113,89 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
>         return 0;
>  }
>
> +static ssize_t kstackwatch_proc_write(struct file *file,
> +                                     const char __user *buffer, size_t count,
> +                                     loff_t *pos)
> +{
> +       char input[MAX_CONFIG_STR_LEN];
> +       int ret;
> +
> +       if (count == 0 || count >= sizeof(input))
> +               return -EINVAL;
> +
> +       if (copy_from_user(input, buffer, count))
> +               return -EFAULT;
> +
> +       input[count] = '\0';
> +       strim(input);
> +
> +       if (!strlen(input)) {
> +               pr_info("config cleared\n");
> +               return count;
> +       }
> +
> +       ret = ksw_parse_config(input, ksw_config);
> +       if (ret) {
> +               pr_err("Failed to parse config %d\n", ret);
> +               return ret;
> +       }
> +
> +       return count;
> +}
> +
> +static int kstackwatch_proc_show(struct seq_file *m, void *v)
> +{
> +       seq_printf(m, "%s\n", ksw_config->user_input);
> +       return 0;
> +}
> +
> +static int kstackwatch_proc_open(struct inode *inode, struct file *file)
> +{
> +       if (atomic_cmpxchg(&config_file_busy, 0, 1))
> +               return -EBUSY;
> +
> +       return single_open(file, kstackwatch_proc_show, NULL);
> +}
> +
> +static int kstackwatch_proc_release(struct inode *inode, struct file *file)
> +{
> +       atomic_set(&config_file_busy, 0);
> +       return single_release(inode, file);
> +}
> +
> +static const struct proc_ops kstackwatch_proc_ops = {
> +       .proc_open = kstackwatch_proc_open,
> +       .proc_read = seq_read,
> +       .proc_write = kstackwatch_proc_write,
> +       .proc_lseek = seq_lseek,
> +       .proc_release = kstackwatch_proc_release,
> +};
> +
> +const struct ksw_config *ksw_get_config(void)
> +{
> +       return ksw_config;
> +}
>  static int __init kstackwatch_init(void)
>  {
>         ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
>         if (!ksw_config)
>                 return -ENOMEM;
>
> +       if (!proc_create("kstackwatch", 0600, NULL, &kstackwatch_proc_ops)) {
> +               pr_err("create proc kstackwatch fail");
> +               kfree(ksw_config);
> +               return -ENOMEM;
> +       }
> +
>         pr_info("module loaded\n");
>         return 0;
>  }
>
>  static void __exit kstackwatch_exit(void)
>  {
> +       remove_proc_entry("kstackwatch", NULL);
> +       kfree(ksw_config->func_name);
> +       kfree(ksw_config->user_input);
>         kfree(ksw_config);
>
>         pr_info("module unloaded\n");
> diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
> index a7bad207f863..983125d5cf18 100644
> --- a/mm/kstackwatch/kstackwatch.h
> +++ b/mm/kstackwatch/kstackwatch.h
> @@ -29,4 +29,7 @@ struct ksw_config {
>         char *user_input;
>  };
>
> +// singleton, only modified in kernel.c
> +const struct ksw_config *ksw_get_config(void);
> +
>  #endif /* _KSTACKWATCH_H */
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20250924115124.194940-7-wangjinchao600%40gmail.com.
