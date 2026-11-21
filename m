Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795295684;
	b=oCqD42BaUQXabzWVSKXqdukN9JnQHMgriAYSx6eIvS6gkAZL6hGTdw3Af1l412d09HUf
	 fUEh7PVgrH2pAi+GM6nn63BP+J48pcvichOo7ybZFPSL+w5nTrVOlAkbgRK/y9bBPaTHt
	 O7m66sgF6xhm2o8gzxptr22K7CL8JDRBtffRYc4lkOFWmNDs/erzT6XwQcrOo2nLm7l1s
	 qqH/0ihczC0TmOCzGKkuhsKe6ADtrg4RgNfbaypLLliyZ0DLrG8TpYktjiPT14xOsoE/e
	 91NKXVSCveqHwX0vI80/LeFuwKKNQ6Q/pmKG3oZVXZEBB7e5ubcwDCo6R+x5G99qvhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JVXIUze55zta93CLasHcBtUF3k3F0VOVstypLu4rWEo=;
	b=ThM5LFaaYIp4ta0cRn3dYXZNpTqE2h7goMAYE6CSdeSgmpa1/F/jrCKrsu9ZmTZx6FjG
	 m9vMsu63xlR/Y4fyZygWbeH94EpTsiWAevhJX5lGmgFizpOmsBf04lZNmk4obNsH+sSZB
	 eiuygd3vYRF2gGPx8J8OjpwRvYngxsFTtjtaECszeFW9FMCYS3hmwjcTwLmWaAffFTwe9
	 GW1DvulV/o4n0S+SKezpqQYA2Xc+Bd+XsRDbCB6144RU5AYASAW3tiYqZnQjpI177M4ot
	 J7hNL240WR0jXriHBCjdDe60ZGmv+99XUcDle5VZmWl31ZroyBoxXho89HpVODvYGjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=daSCu1rV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D5606A333
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 21:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4D5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=daSCu1rV
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5ece6c1d1cbso655388e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 13:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795295682; cv=none;
        d=google.com; s=arc-20260327;
        b=l25CYg2V6RUaZ7CXD22f19hOBIG2+BLmeUK+o9QWJK/hVJ0nVdtV+DVVkNtGUOdbO5
         Lorsits2ohKf1yKCX8s5D9D1rwcID7h62btVA1O8EBmfHbAsXAdCyCllUFGcU+Ujawx9
         hdIAUiOMmDTp45yYuMLOZrHFoc8sW7iVrLE48oSQCwoZJSOngt58OmgaSqBxny72y3X+
         0yhXjUPA3KpJKzILlv7tkSSygjdw8K+cvdjngLa4szsQPcD286NOyPmBXa3evvtSVFWQ
         DHDK9pS8RURHl/06Yi5hllUIj8HkgR6uUn5Q4G8VunXs/Ji+EkyuXmMIgZLI8T8Jc300
         D6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JVXIUze55zta93CLasHcBtUF3k3F0VOVstypLu4rWEo=;
        fh=nsHOkoCVb6QboZTn1bznBdVlNV/T+LkGFAfnsOAm0u4=;
        b=G4Iurcsoh+7YzgRMvu2gn6FnWWhyTU9FHBl+SDz3twaNMsw9etFQ7JGVVv2w2LedD1
         v2CYEbouiuttCCmOXdOkkGPmgLoxiLzb0RTRwMYS23H4g6WzdNt9ZoXBnN5QwXKWPb2X
         sy4ADoDKLWw3lOaiaGFYup6dIj8XUCQcVuB+I+6blGo+yib6w4j5r8AQ2Vx6rlPmndzq
         wzYTxuLl65e8+31BOJVcyhTvtu7NHWHs0q3i6scRtkfzTM6+snIvhNgIuGuC3OULX/yP
         ign62659X+GKthVH+I2phpXS+UvmGZltZTNBhO5/qBSnu+qfQ2qg2K+o64VW/p/7QEen
         fyTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295682; x=1795900482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JVXIUze55zta93CLasHcBtUF3k3F0VOVstypLu4rWEo=;
        b=daSCu1rVibP6KmyXonSqkr5VdhcRGAjLASbLzwqytA8wCCYmTkuypGNc9yh3g8tYro
         gcoLLfqIjpVrzh1a0Qg7pINTcCVmT9WihsvEDNJcu/1iRmj1MkHnYT/nJliaeU0aCGor
         ZG2WKAD3ONqob74E9Lt0wohObg+p2u+kz5zkhu2KVXO9dz6Xj2PBhjk7iII9lIDYlyMQ
         a+RLJ+MTy74iMQR/JNE8Gmj11KQj3Vt/CQcLsv+BFt7Jg6Hkt2MjgL5KbLZs78NXeif2
         TMXPkxEW/EQNSJFgb/HHs3nh65h259gh7DP4ybPfO/JH+toj05KzMIIUO2fFkflD5GF0
         JmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295682; x=1795900482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JVXIUze55zta93CLasHcBtUF3k3F0VOVstypLu4rWEo=;
        b=RCcqdUD0DV5tfXf4VSbDymQuGrH2KxL2jIk4dVOX4s7OWJ4CN6GCuVAFSO8SpN3Slg
         P/L/KnD8T3lEoA7VYA1sNUySckwOt/G7lEh6dkXZH4FlMK2gUTQvoKoghjodSBA9SVuy
         zqfTrDLF7Y4BR4mjAqExMYYIqmSeEm5JF4PNnKYbYoTafGBy46jHmPNh73LNh4NSen/M
         AyJfu0ZO2MCvT6jOt00y6ulSaTxdS7LDQg5+uwwZXYZpkEKo0NE3ueW4Vmo5yyYUBmJx
         n6hRG6Mi20kOVtRdnLOFOzEFTTc+aYmmxz4UlDTgzcq6Nlr3Sjsn0k3POBQQcQ/wOZiB
         ccAA==
X-Forwarded-Encrypted: i=1; AL+hErF/fgZdeOXjOCDDTVTZEIBofGwDejqP8NpLUOaBxXKOxqbhcVWqYaSxfFJ0GS7KHbEbeBIZjXY+2snpXMV1FA+Ebrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QIzJXR2WvK3T7+zx7dbFqyUF6U/uIuRkpKBhcgesGwlctITmx
	x9EN7V5oK/B3WoLw9dJCNWBLH9pJxHVXovF4sUyaXXoTIm4xXptPuL6cpOocQ+Y4lOXSl/tBPt2
	CKjm7NxPIBXMvX9YWERnimUFHhiBe4gs=
X-Gm-Gg: AZFdTZfFJOFwgyhja+A0GtYiiNRxSbisEZQkvk7BNnjyuZWZ2T+M3z3RaW2GXg01pef
	jrxIYzVHl6H/AuO07h0szh+sIBmLhTLIR5GOC2TA/gpyCwYpqWMb36Ek5pb5Dipytmflk4kfst0
	oZfcKy9EQZ2l2gmR5V7gcMC8h+3uLxdzgw34IPZNQ1Isr8BhPAOiQHcyxl7XejV7IkPPJOrKH3j
	FuPmBqgJvv3Zo313T1ZrOfLhnWDTMtvrZ2UQCayYySyDlH1cCa6sQVuU/Ao5Eg83BghzWI02MnJ
	w6hOShgm0GV2MUKpy8DKsw2VQKfAsH/206P7wMGGBsZgVLBZXcV7Oss0pQ33R6wlydzIJrgOjr6
	7kDlnY1K2HUatfZjJjLppRbGXjpgRImsm5dWDS8w+p5IjrGvRPVwB4PniAgpV/LPt9vubyl5yLp
	VWSQFEXVWGM4KdhUzbF0bF9teNUfV9GeCV0pBJT5mMlqke9Fb8tzPO5v3fe7a/cvgcCPJkI5FQ6
	FsHcuSUCCtG8Lpw9Le6Dv2IBPvfE2C8O1+skPXWB5Kp9ta5lj2Xg2RAuxRWOterXYjaGn/H
X-Received: by 2002:a05:6122:17a2:b0:5ec:d70c:6326 with SMTP id
 71dfb90a1353d-5ee8af988f4mr3347118e0c.23.1795295682517; Sat, 21 Nov 2026
 13:14:42 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1218ce4d98a4c6ab6df6279c34d973b9d033755e.1795042969.git.edumucelli@gmail.com>
 <undine-1795189391477787363-17dbbdcc692ec995@undined.local>
In-Reply-To: <undine-1795189391477787363-17dbbdcc692ec995@undined.local>
From: Eduardo Mucelli <edumucelli@gmail.com>
Date: Sat, 21 Nov 2026 22:14:02 +0100
X-Gm-Features: Aa3M54q79aKI1og8D0RQNbEoTQYxDDLEgGbfjp3m4OsVj8VXK4D6VmegMI0QjiM
Message-ID: <CAK0NWSOGSiBEHMaMg1vcheH9-EHU4fUW3sEQsg5H5Btr7+S9og@mail.gmail.com>
Subject: Re: [PATCH] tools/bootconfig: Preserve structured histogram filter strings
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Masami!

On Fri, Nov 20, 2026 at 4:43=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> On Thu, 19 Nov 2026 00:02:52 +0100, Eduardo Mucelli Rezende Oliveira <edu=
mucelli@gmail.com> wrote:
> > print_one_histogram() expands the hist.filter value through an unquoted
> > command substitution. Field splitting collapses repeated whitespace in
> > quoted filter strings, and pathname expansion replaces literal wildcard
> > characters with filenames. The generated command is already incorrect
> > before run_cmd() evaluates it.
> >
> > Print the filter with printf and a quoted command substitution so that
> > structured histogram filters reach the generated command unchanged.
> >
> > Fixes: f134ebb28126 ("tools/bootconfig: Add histogram syntax support to=
 bconf2ftrace.sh")
> > Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
>
> OK, looks good to me. Let me pick it.
>
> Thanks!
>
> > ---
> > Hi Masami,
> >
> > Thanks for picking up the run_cmd() quoting fix. I had this small
> > follow-up ready in case that patch went in.
> >
> > Here's the thread for that patch.
> > https://lore.kernel.org/all/97454eceb5d56bf956740b8998972767bcfe6c70.17=
93216183.git.edumucelli@gmail.com/
> >
> > This uses the structured hist.filter option documented here:
> > https://docs.kernel.org/trace/boottime-trace.html#ftrace-histogram-opti=
ons
> >
> > I tested numbered and unnumbered histograms in a temporary tracefs
> > instance on my Ubuntu machine, running kernel 7.0.0-38-generic. Repeate=
d
> > spaces and tabs were collapsed, and a wildcard expanded to filenames.
> > With the fix, the generated and installed filters matched the input.
> >
> > The run_cmd() quoting fix was present in both versions of this test.
> > This additional change fixes the string while the histogram command is
> > being generated, before it reaches run_cmd().
> >
> > Feedback is welcome.
> >
> > Thanks,
> > Eduardo
> >
> >  tools/bootconfig/scripts/bconf2ftrace.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > base-commit: 0ad31c3252d4c626a93ae6251340ef86b18342d0
> >
> > diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfi=
g/scripts/bconf2ftrace.sh
> > index 6a3535a2c..0992e54c6 100755
> > --- a/tools/bootconfig/scripts/bconf2ftrace.sh
> > +++ b/tools/bootconfig/scripts/bconf2ftrace.sh
> > @@ -163,7 +163,7 @@ print_one_histogram() { # prefix
> >       print_hist_actions ${1} "onmatch" "event"
> >
> >       if xbc_has_key "${1}.filter"; then
> > -             echo -n " if "`xbc_get_val ${1}.filter`
> > +             printf ' if %s' "$(xbc_get_val ${1}.filter)"
> >       fi
> >  }
> >
> >
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



--=20
Eduardo Mucelli R. Oliveira -- http://eduar.do
