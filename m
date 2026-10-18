Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142E33B975
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299162; cv=pass; b=WunKU7n7LW+yx6xmmBaw+26QleKG8WNBNYH9u82s5ilVRWnYt0OuVjgPcGuefC0bwiXI04E4fFAvG9L8D/ifrPsDkfj7XU2D6bipJdFSAfT9vH/PvApy3lSz3cgbw8skgJtVDLadFMpfRSrBEV1XU/ZC7b2dygK9noR+ja/pB6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299162; c=relaxed/simple;
	bh=hAtRSVMMTHxmyC0YpP48NUQGHVcPPL9epUfP6boAMt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkqUDu4NjvEt5AH+QCSu+q6g7y75YTkSbaHEeXnGrgT3skYFPVYBrcqa4ExZqehOjvKEWPwg1sncgBuZMkgpmqtnaSDkxTkF0HFbtU2+IW1z+aMgecnPdJlFtawZ/uPKKqxk4OZoxn3JcuOrRCnqHqrQqL7+JCMibOHv6kIt0TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TlnI34f/; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlnI34f/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-535f598d126so153761cf.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 21:52:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792299160; cv=none;
        d=google.com; s=arc-20260327;
        b=Ke8LsU0TI531tJ+fdkHiKz8T7RAujmkHmrHoKFHiV51SK7SfParf/hM19zMrpJtccM
         WLKob0kSDQXppRaBk1CqSOubtSQVj29Cp/NpIUrEBW72dl//k9KXOnEo9QNWR3dpz+/M
         jn/o6KfsbuXtn6Nhvfr6drCCGSj0mCGQPofGbifo7hmWrzv7tfycVpcdBimt7m11kLCN
         keZqsdQXhieas416f9mNgEzRHfxkVuwHYS486IO0BSFe9IKX5P4sDOBQLy4pc9ey7aE7
         7ATVb/vZd3Qh4QBs5Zei3TCwzIHCPKSDDLmNmd396ebd8ZB35o+c20fl3SYsIH9sLfib
         iOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/j83INDW+E0oYwL7EQYpoQA+T4KbuWW9MUJmzBfXlTw=;
        fh=PJ4b4ojaISj9NuNzR+5h5Fhza/g+ZBGXneF9H5lBm20=;
        b=aDjkRk3V78i9t7iY+fkDuedMc7OUMw0cQbg6XMxaiY8IhCBN8/MjiQYeaqNIObSdMO
         Ef030hAMRNu6X8tqRTiIaun7uuGZPGELHKBrWQoejIGg1z15BxlZPpNsfZMN2gwO79DN
         2kE3bIOaPqRkB3Brvn4m9LVpYELWLu5xP+sciyc/wD38lCVU6LXjxuoEBmYOG+kUUR9h
         K032S2hje8nOQFPC2niQHLPVS2tBf4mMjs4L3W6virujBQ9fB3drNeqR2Do8jcxjIf9M
         RkdZGpmgaaC5zf8IkztINbJJhm3p2nyoMSvWdfuDKTFi9BNdSHKHBkSNmsx+iWaq9tLo
         GByg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792299160; x=1792903960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/j83INDW+E0oYwL7EQYpoQA+T4KbuWW9MUJmzBfXlTw=;
        b=TlnI34f/4I6xROuSZywQgkn7gXSLd5Npjchb7PSd1eJVLno14lERWIFHioJtf/1P/F
         1XFzam+Ix1E3OR43MrfvIoVibroPifRaXzFZTdbrwxarICi6WEXlmFkoSyJpST5AbKIT
         NW/f3tCxHvGPqe2OTBpm8eeVXuf8cMvVJizRXl4vgvDvbJGATuIfMPGLlZoIpWcYmATt
         Y3Ban3L0yuKZPXR3pl7qorFeieMNcAVgTrtJ5rnwce02aSlXqRSgdvHv6a2hDA7Rcjy7
         6463HADXg6XPx1FD5HpaK5aCqqu/aaTREmF3eYptyJSy3VtWqp3nnLNJHJK4jtrBM4Xv
         ce0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299160; x=1792903960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/j83INDW+E0oYwL7EQYpoQA+T4KbuWW9MUJmzBfXlTw=;
        b=tyjxZBjW2CIdX8XGQmu88SUSPR3qAYLyuUuMcAfh9Mp9+8QthORVOSuuKDhy7xunQF
         e96RWqfN6lCkrF0sjD8kf4BgF400DNhANSDCT9ci6H+BomKcwzvZF5w36n1DwMXJxEn6
         hKOpecMWL1e1xMYby4SKQYnoc5OQhr6Im20uZKX/LKqoOLxZxw3Eucvor1IEnpUwkUGW
         lyNfHcIwKbVP7ScO1g8vbcuJirXPh1Y+wbX+e8lLhD94pdemnEwC5Fnw8vyxKczzkYbm
         ZnGpkVEq6iB98FnFAK0YsbMch2Mm37aI5wXMfXEUfdUTxYmgaQHU9FlcY0aZCrY/Zkws
         x12w==
X-Forwarded-Encrypted: i=1; AKwUvBy6kXaaqGK36QH9qccFNesRfPSMiXI9lGa1G5ePXRTf4Lq8Q4nW0H5QtahudL7Dro18KDS6Jt3NA7Ff7OUfB46VajA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNR9Rp3K0U09yfBQJC9X18xn3U31XqfjNFaTmifJ/aKALH56ie
	zLvUh39GTFXjHiuOP89emn7HGhVm2kyKfRHXdaJ6MrKJl7ZmYgtIjZEQeCFXrhf29GJyDg0pd7P
	PxGMx7RX6rMOaZi8yJFpa14NYm/lkfg5xv8QH0U+N7a0UJR9IqktoU4EFUnUjqQ==
X-Gm-Gg: AYBFou2Dfh/9CfqST6LzLkKz5HUyku+csNvgTeyWT72fCfI0zywRy4TcaD1gs91bu7T
	UbvBLMC53BGPCWG3+U1iCd0Dncm1uzj9+O3J6El47hNStp3U4Jx2WqjUQ30/Yxt8bzDOJJzDko0
	ghhyehl7RJpW1Mv40K0fu6SXjU1YfoAGECYF5pmoCeVSdUwRCAL8yMmNZGze8xbxeQRIcIS0dL8
	zDp3U+/jbYqxFZN+Te6quZfOQNSHh+jG0JmXBkTfPscOTFf+E+ETDJXR0yW8T9ldR+Stzs12od5
	LoHSAxXADyKNte3UIKfna5mmHY9snYRnG1geV4uAC/28+rSudNITYKoAbUFWmoBMpkp5
X-Received: by 2002:a05:622a:15c2:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-53646271decmr19987131cf.9.1792299159704; Sat, 17 Oct 2026
 21:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791410885.git.abhishekbapat@google.com> <aae089a81ea891e1bc7e3ad171064d37d800ad1a.1791410886.git.abhishekbapat@google.com>
In-Reply-To: <aae089a81ea891e1bc7e3ad171064d37d800ad1a.1791410886.git.abhishekbapat@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 18 Oct 2026 08:52:27 +0400
X-Gm-Features: AclHuK-Wl1wHq9C6FbkV2z85b221S8kRzKVDRSqQmdSzTuR5W-gPJA5u6SMeDIA
Message-ID: <CAJuCfpF+kVSa0Rb0pW2gSwkBF57u-JC0J6gwFk62iGUpXVNwSw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] alloc_tag: Extend allocinfo_filter to support
 tracing queries
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 2:40=E2=80=AFAM Abhishek Bapat <abhishekbapat@google=
.com> wrote:
>
> Extend the allocinfo filtering mechanism to allow users to filter tags
> based on their trace state.
>
> Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/uapi/linux/alloc_tag.h | 8 ++++++--
>  mm/alloc_tag.c                 | 8 ++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_ta=
g.h
> index dafcba2f7e2c..a96054ac2237 100644
> --- a/include/uapi/linux/alloc_tag.h
> +++ b/include/uapi/linux/alloc_tag.h
> @@ -38,7 +38,8 @@ struct allocinfo_counter {
>         __u64 bytes;
>         __u64 calls;
>         __u8 accurate;
> -       __u8 pad[7];
> +       __u8 trace_on;
> +       __u8 pad[6];
>  } __attribute__((aligned(8)));
>
>  struct allocinfo_tag_data {
> @@ -54,7 +55,8 @@ enum {
>         ALLOCINFO_FILTER_INACCURATE,
>         ALLOCINFO_FILTER_MIN_SIZE,
>         ALLOCINFO_FILTER_MAX_SIZE,
> -       __ALLOCINFO_FILTER_LAST =3D ALLOCINFO_FILTER_MAX_SIZE
> +       ALLOCINFO_FILTER_TRACE_ON,
> +       __ALLOCINFO_FILTER_LAST =3D ALLOCINFO_FILTER_TRACE_ON
>  };
>
>  #define ALLOCINFO_FILTER_MASK_MODNAME          (1 << ALLOCINFO_FILTER_MO=
DNAME)
> @@ -64,6 +66,7 @@ enum {
>  #define ALLOCINFO_FILTER_MASK_INACCURATE       (1 << ALLOCINFO_FILTER_IN=
ACCURATE)
>  #define ALLOCINFO_FILTER_MASK_MIN_SIZE         (1 << ALLOCINFO_FILTER_MI=
N_SIZE)
>  #define ALLOCINFO_FILTER_MASK_MAX_SIZE         (1 << ALLOCINFO_FILTER_MA=
X_SIZE)
> +#define ALLOCINFO_FILTER_MASK_TRACE_ON         (1 << ALLOCINFO_FILTER_TR=
ACE_ON)
>
>  #define ALLOCINFO_FILTER_MASKS \
>         ((1 << (__ALLOCINFO_FILTER_LAST + 1)) - 1)
> @@ -75,6 +78,7 @@ struct allocinfo_filter {
>         __u64 max_size;
>         /* filter criteria only; see allocinfo_counter.accurate for actua=
l accuracy */
>         __u64 inaccurate;
> +       __u64 tracing;
>  };
>
>  struct allocinfo_get_at {
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 262f00f2bba9..8e63f347657b 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -250,6 +250,7 @@ static void allocinfo_to_params(struct codetag *ct,
>         data->counter.bytes =3D counters->bytes;
>         data->counter.calls =3D counters->calls;
>         data->counter.accurate =3D !alloc_tag_is_inaccurate(ct_to_alloc_t=
ag(ct));
> +       data->counter.trace_on =3D alloc_tag_is_traced(ct_to_alloc_tag(ct=
));
>  }
>
>  /*
> @@ -323,6 +324,13 @@ static bool matches_filter(struct codetag *ct, struc=
t allocinfo_filter *filter,
>                         return false;
>         }
>
> +       if (filter->mask & ALLOCINFO_FILTER_MASK_TRACE_ON) {
> +               bool tracing =3D alloc_tag_is_traced(ct_to_alloc_tag(ct))=
;
> +
> +               if (tracing !=3D !!(filter->tracing))

nit: Compilers are smart enough nowadays to convert u8 to bool without !!

> +                       return false;
> +       }
> +
>         return true;
>  }
>
> --
> 2.56.0.385.gd3acb90ef8-goog
>
