Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A7309F08
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 05:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299810; cv=pass; b=IqPXtINItxixEAwn8Rz22Xvs4MQvh7VUeTFSVsbLQjYNn5g1PStwOA+e7Tj6ftpHtF1T/3SJN4EOOTVJTfk7Z2ZnpzGEy5sFanBp7dPC8WKbYHuf5DNGHvEjW1cz7qqgdQytK4J3zwL+nmAHMLSu3Mt7tF0dQQWCVDU6jML/6e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299810; c=relaxed/simple;
	bh=tkQQoO3vvVQs2XtJl00nGi7vaebFncL/Xj7fbR+UOxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Atl3SO+y8nJuVnnWWe3OCsp1qpPqSE4MwvzSz3RKOUYUhFJpG6wgfo9FZhp4rkNUQBpjLXcZ0ipXT1lZKn+kw3TQcXYWSwDNfNPtSwzXBhe+fD6XgwP0hJ0yppVxYlTR6gTCVWJXS4yzuXRv8LWf1f2KaWcmUuvTbkPmSKW0BV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kh006Arz; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kh006Arz"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-535f598d126so154591cf.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 22:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792299807; cv=none;
        d=google.com; s=arc-20260327;
        b=MNzfEiqC5RMNxy7n83HIsy29KEmHy9jczDTThilvNV8/FU2AjhWuaVL10y2AO/+P1K
         66xom9gaUXBjVBxsInyZQZoVQme7Sd3GOYt5921XODo4q5aJhzTEwWnXyQ8UGxuTiKuu
         b8m2xN0EQfGRSczGkflstGuRuqmQP/Ok2ynKMRHkA/1oT55FnoqpJt5frXeZk869Q1xU
         ytpfgUmRxQ1iX4s2El6fUor3UjEst2pLdc8k3gyj8Mwj6VRroI4z/m0bxLF4m0RphNxZ
         d3LzcblaxUy2ZDEupbLYbS4SrDh7j4bp4W2j8a+YGZoanBkxLdJ/AY/mRLv3TUxscWZz
         5eDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJriBqGLviqWmHHPERdjBK4yfnHo9QPRMrJXUUU8Ae8=;
        fh=xwpr/3pVZuCaNlSJA0hOhBtb+CsNUEtWb0RfI323kgk=;
        b=P6wn4OHC41sZ/HRuFgq+wVUzhLIzC/AVEvSNRGu9vaT838lChNKBukvYheaP7zivA5
         nUbd+hQ10H+kKqeSaY2XQnCQUEB5DnrVEJNMj3L/AYHZE3knEDd3oJgZd8cDxZLAEIbJ
         itphI/OFRbFyTKkOyxBsoLDKu999gduZVKDqEW3xfodKt+5Nvn6iaiHCv/MVnACFaZZK
         yLZ/dQndplzCScHeQ5gEt8Jzz10gGXNftNXmweNP2BA7xr4DDfIuvmjjKOML+5QtuNrm
         3jiC63qTnqRFg4zTY0z0KOuEFBikZPJdoNgZ9hSxydv5S1FdRjzltquSXWZlb/KqFxT1
         qUmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792299807; x=1792904607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WJriBqGLviqWmHHPERdjBK4yfnHo9QPRMrJXUUU8Ae8=;
        b=Kh006Arzks7b3rVY+JEdOOCBJqx5yOIfyxikye4G5nooShzW6f0N7i6nDpPGTvR3Mv
         M0tjo2i1Tt2OR3aOsScesbq1I6u0vwPJCG+c/jI0BM7x9PhZYCkOcnULGzEXl4yJi8QE
         ih0rV1PeS9flYqbc3DKu613cpq+zbq6DCH41WBlPVqKUXWLNlQ0i5L5AU//lXrB6bzTw
         vCuFl3VBrlz6rMvSgMpkb0Xlx4hdmT7ESGP6LRJvqWZWBNgTs+mF7IOchyBxSfd0Sg7w
         A44oIwdn0hH+gRW4OyQtJl7g7wnNg7wWVbkI+H9VC5iz1Yhd/1tGUZC9L+oHekzD7kQ+
         OvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299807; x=1792904607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJriBqGLviqWmHHPERdjBK4yfnHo9QPRMrJXUUU8Ae8=;
        b=ZZEUo5Bpm5EbI+qmWq1aGZdEuT5GLDwaxF0xzQEv+I9ctA4bazyNWMHxFVINsbkGdQ
         /xQxP4irS9Yrr1YYtKSbAbxVU3iTwkxO04qaFbd5AnTTTeSy1n0JFD2LrcMmsLNuzWTq
         YgU3m/6srtSr8qiNAwNCAeT1rhm7wqlGgEq+a4h7IviKQB0+rJdgxU2fVZfr/iaAUfh2
         lJ0UxnD8yqn+i6nvZQgE3gSGFoq0c629VGURDq/MuZa4JAjcsDeG0ttK/GejOsrqZEWo
         +l8PZajnX+JzM7mwhORwa33Wg1JUTik0l9EGRcI4TryPAo54/AgiV5y+4zoxncDOrsJX
         deVg==
X-Forwarded-Encrypted: i=1; AKwUvBwhuNoZ+YkhoL6UJR1ofKPqFkdRUdoviabU4N7uqP86Eb+T3SrJSH2lYrVwRrcUVRx7R1vt8Skp20//sm8C/pNEC2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFsVr4Qy799X4SSsNlIwVIlqWeMiCsenBCC2Dz6z4iTRKXR5fH
	3g6B/ZQhLtpZk/nJzJzfv9pWFrn18jJJEVC9VNbA9lBoo8aEeKNZ9DuNlmE3V0tO1yQyDvuh9S+
	EkGOTXPK9AY/kkg38ZGBU7Ua0iUtiVf5ovBzrsq18
X-Gm-Gg: AYBFou0BjOfPAJb9icKjrFjSRomMhoO8+ggLuLdrsGB8ReDOA1KQmeUElTStlzxI32l
	MrG2rcv/CUsrFfv16y4TiWhClMLV+xLnU5Wv3H9uhrX7v/jBE79r2/b62ZcgPJPTwXflOhH69kD
	EVjGdlU7Gu5MRDXSqrcTanL/1cs0UiXmQz8QVgJsTfAhHYKxUD7B0sXQQa0qZsA5fU/YS/WY9/n
	kyyrjoaXXSyy7YOyVv9qXYm0q27m5qtYcA3pHBU+kqdll+RPYGKzBhcZG18qxxcpewihGxYCul9
	bFQGVfkw4N9OaltrrwbB4UwsMVlNEXAXdiublNlx/pqYTLErJsGK/0DFr2SPT0N7CvI4ij2bclm
	dfy0Dabz4kqb4KiKtnyKFYtteM4n6U4ptVWArBrY=
X-Received: by 2002:a05:622a:15c2:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-53646271decmr20079161cf.9.1792299806552; Sat, 17 Oct 2026
 22:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791410885.git.abhishekbapat@google.com> <ed2e9cb670af7d013aaf6585aea551587647f070.1791410886.git.abhishekbapat@google.com>
In-Reply-To: <ed2e9cb670af7d013aaf6585aea551587647f070.1791410886.git.abhishekbapat@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 18 Oct 2026 09:03:14 +0400
X-Gm-Features: AclHuK_oDOaokU5jt01qhnnQcmoO0pUXkqXeV5gDjzXh3IzX5q3ZSZp6iLCM8BY
Message-ID: <CAJuCfpGHwan9YDjn_9-8EGKT-ZP=GNVPnfY8zvv5nw9GUK5qiA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] alloc_tag: Add a test for trace state toggle and filtering
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 2:40=E2=80=AFAM Abhishek Bapat <abhishekbapat@google=
.com> wrote:
>
> Following the introduction of the ALLOCINFO_IOC_TOGGLE_TRACE IOCTL and
> ALLOCINFO_FILTER_MASK_TRACE_ON filters for selective memory allocation
> tracing, update the kselftests to validate this behaviour.
>
> Introduce `test_tracing_toggle_and_filter`, which validates the
> architecture by:
> 1. Dynamically flipping trace execution state for a designated allocation=
.
> 2. Query the same tag again, and check that the returned tag reports the
>    new state in its `trace_on` field.
> 3. Restore the tag's original trace state, also on failure, so the test
>    does not leave tracing changed on the system.
>
> The test uses `dup_mm()` function name with the function filter in the
> IOCTL to run the above steps. If the `dup_mm()` tag is not found, the
> test is skipped.
>
> Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  .../alloc_tag/allocinfo_ioctl_test.c          | 113 +++++++++++++++++-
>  1 file changed, 110 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c b/t=
ools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c
> index 74fd64b2370c..eb52ca1a1dc4 100644
> --- a/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c
> +++ b/tools/testing/selftests/alloc_tag/allocinfo_ioctl_test.c
> @@ -48,6 +48,11 @@ static inline int __allocinfo_get_next(int dev_fd, str=
uct allocinfo_tag_data *pa
>         return ioctl(dev_fd, ALLOCINFO_IOC_GET_NEXT, params);
>  }
>
> +static inline int __allocinfo_toggle_trace(int dev_fd, struct allocinfo_=
toggle_traces *params)
> +{
> +       return ioctl(dev_fd, ALLOCINFO_IOC_TOGGLE_TRACE, params);
> +}
> +
>  static bool match_entry(const struct allocinfo_tag_data *procfs_entry,
>                         const struct allocinfo_tag_data *tag_data,
>                         bool match_bytes, bool match_calls, bool match_li=
neno,
> @@ -289,6 +294,8 @@ static int run_filter_test(const struct allocinfo_fil=
ter *filter)
>         return ret;
>  }
>
> +static const char *target_test_function =3D "dup_mm";
> +
>  static int test_filename_filter(void)
>  {
>         struct allocinfo_filter filter;
> @@ -304,11 +311,10 @@ static int test_filename_filter(void)
>  static int test_function_filter(void)
>  {
>         struct allocinfo_filter filter;
> -       const char *target_function =3D "dup_mm";
>
>         memset(&filter, 0, sizeof(filter));
>         filter.mask |=3D ALLOCINFO_FILTER_MASK_FUNCTION;
> -       strncpy(filter.fields.function, target_function, ALLOCINFO_STR_SI=
ZE);
> +       strncpy(filter.fields.function, target_test_function, ALLOCINFO_S=
TR_SIZE);
>
>         return run_filter_test(&filter);
>  }
> @@ -514,11 +520,106 @@ static int test_lineno_filter(void)
>         return ret;
>  }
>
> +static enum ioctl_ret toggle_trace(struct allocinfo_tag *target_tag,
> +                                  bool enable)
> +{
> +       int fd;
> +       struct allocinfo_toggle_traces toggle_params;
> +
> +       fd =3D open(ALLOCINFO_PROC, O_RDONLY);
> +       if (fd < 0) {
> +               ksft_print_msg("Failed to open " ALLOCINFO_PROC ": %s\n",=
 strerror(errno));
> +               return IOCTL_FAILURE;
> +       }
> +
> +       memset(&toggle_params, 0, sizeof(toggle_params));
> +       toggle_params.filter.mask =3D ALLOCINFO_FILTER_MASK_MODNAME | ALL=
OCINFO_FILTER_MASK_FUNCTION |
> +                                   ALLOCINFO_FILTER_MASK_FILENAME | ALLO=
CINFO_FILTER_MASK_LINENO;
> +       toggle_params.filter.fields =3D *target_tag;
> +       toggle_params.enable =3D enable;
> +
> +       if (__allocinfo_toggle_trace(fd, &toggle_params)) {
> +               close(fd);
> +               return IOCTL_FAILURE;
> +       }
> +
> +       close(fd);
> +       return IOCTL_SUCCESS;
> +}
> +
> +static int test_tracing_toggle_and_filter(void)
> +{
> +       struct allocinfo_filter filter =3D { 0 };
> +       enum ioctl_ret ioctl_status;
> +       int ret =3D KSFT_PASS;
> +       bool initial_state, target_state;
> +       struct allocinfo_tag target_tag;
> +       struct allocinfo_tag_data_vec *tags =3D calloc(1, sizeof(*tags));
> +
> +       if (!tags) {
> +               ksft_print_msg("Memory allocation failed.\n");
> +               return KSFT_FAIL;
> +       }
> +
> +       filter.mask |=3D ALLOCINFO_FILTER_MASK_FUNCTION;
> +       strncpy(filter.fields.function, target_test_function, ALLOCINFO_S=
TR_SIZE);
> +
> +       ioctl_status =3D get_filtered_ioctl_entries(tags, &filter, 0);
> +       if (ioctl_status !=3D IOCTL_SUCCESS || tags->count =3D=3D 0) {
> +               ksft_print_msg("Could not retrieve IOCTL entries for %s\n=
", target_test_function);
> +               ret =3D KSFT_SKIP;
> +               goto exit;
> +       }
> +
> +       target_tag =3D tags->tag[0].tag;
> +       initial_state =3D tags->tag[0].counter.trace_on;
> +       target_state =3D !initial_state;
> +
> +       ioctl_status =3D toggle_trace(&target_tag, target_state);
> +       if (ioctl_status !=3D IOCTL_SUCCESS) {
> +               ksft_print_msg("Failed to toggle tracing\n");
> +               ret =3D KSFT_FAIL;
> +               goto exit;
> +       }
> +
> +       filter.mask |=3D ALLOCINFO_FILTER_MASK_TRACE_ON;
> +       filter.tracing =3D target_state;
> +
> +       ioctl_status =3D get_filtered_ioctl_entries(tags, &filter, 0);
> +       if (ioctl_status !=3D IOCTL_SUCCESS) {
> +               ksft_print_msg("Error retrieving IOCTL entries with trace=
 filter.\n");
> +               ret =3D KSFT_FAIL;
> +               goto exit_revert;
> +       }
> +
> +       if (tags->count !=3D 1) {
> +               ksft_print_msg("Expected exactly 1 entry, but got %llu\n"=
, tags->count);
> +               ret =3D KSFT_FAIL;
> +               goto exit_revert;
> +       }
> +
> +       if (tags->tag[0].counter.trace_on !=3D target_state) {
> +               ksft_print_msg("Entry returned by trace filter does not m=
atch target state\n");
> +               ret =3D KSFT_FAIL;
> +       }
> +
> +exit_revert:
> +       ioctl_status =3D toggle_trace(&target_tag, initial_state);
> +       if (ioctl_status !=3D IOCTL_SUCCESS) {
> +               ksft_print_msg("Failed to revert tracing to initial state=
\n");
> +               ret =3D KSFT_FAIL;
> +       }
> +
> +exit:
> +       free(tags);
> +       return ret;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         int ret;
>
> -       ksft_set_plan(4);
> +       ksft_set_plan(5);
>
>         ret =3D test_filename_filter();
>         if (ret =3D=3D KSFT_SKIP)
> @@ -526,6 +627,12 @@ int main(int argc, char *argv[])
>         else
>                 ksft_test_result(ret =3D=3D KSFT_PASS, "test_filename_fil=
ter\n");
>
> +       ret =3D test_tracing_toggle_and_filter();
> +       if (ret =3D=3D KSFT_SKIP)
> +               ksft_test_result_skip("Skipping test_tracing_toggle_and_f=
ilter\n");
> +       else
> +               ksft_test_result(ret =3D=3D KSFT_PASS, "test_tracing_togg=
le_and_filter\n");
> +
>         ret =3D test_function_filter();
>         if (ret =3D=3D KSFT_SKIP)
>                 ksft_test_result_skip("Skipping test_function_filter\n");
> --
> 2.56.0.385.gd3acb90ef8-goog
>
