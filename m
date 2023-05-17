Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E9C77B75
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 19:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEQTiB (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 17 May 2023 15:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjEQTiA (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:38:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A3955B4
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 12:37:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so760595a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684352250; x=1686944250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EGKI6H/r7fSXnuBx9f0+4FVv9qKurvHdpDRXkzgKVVE=;
        b=dST0i2fL5crJmyksJX0862DQUmET9sHJlkPm04jxbIwsJnbNUW7+0b9DaPO9SxViNp
         8CzG00bl4e2iNhYUUIqZpckBCyAUm20fVCmG2RA76lWUFaM4nC8fP1fK2o1BbU/ipu7m
         Bu3FNI0mAQY4PxO8q5NtnD+m9tmxVXzdQOtzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352250; x=1686944250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGKI6H/r7fSXnuBx9f0+4FVv9qKurvHdpDRXkzgKVVE=;
        b=hsvT4R2QWOzzkuCPF1QPbbbKVxlwI4NJ44C4oe1hYfJ1OhvTx4ep+t//kbbgneFmjA
         KP3w21TUVQNNANHxP7giqP6AXJnooSY14rlfbX9gc5pJS4/E/goaB2RT1SgCLvMISXE/
         +VxcwSsea6p5d6SOik2wkGxBQif1c+Y1CJaY4p73N5nFCT6WNm0jo5ubFFpfr4LDFQVE
         ChcLzi0adtpPhu2Q+lu9jv7KPGa/6d2ZwMuW9dk728K4xhixOP1HYpBIuf21Ee/mMRho
         m4QI6YEnwd9GzVYtdFUdyhvMyTbkGQiaHToeHzSV/fXmgVI5TwY6zFPI2QuiYUnUSeul
         MEsg==
X-Gm-Message-State: AC+VfDw+GMbdF34w2KwiTiGLw0k0HVk5hqkilap/vzTGKv8DFu/krZCI
        OUlW3GWz+FXD69uWn3+96vR+RS2Nv5m3Ply2UPkwVsdc
X-Google-Smtp-Source: ACHHUZ74/zArBvgWsm5LDAiD4r6F9OV/xuBHj3NXRNEqAz7yQ7txOAIFC+4ufzokY14NgLEL4t53lQ==
X-Received: by 2002:aa7:d7cf:0:b0:4ad:738b:6706 with SMTP id e15-20020aa7d7cf000000b004ad738b6706mr3370026eds.2.1684352250289;
        Wed, 17 May 2023 12:37:30 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id v3-20020aa7d803000000b0050d83a39e6fsm9763513edq.4.2023.05.17.12.37.28
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:37:29 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-965b8a969b3so80355066b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 12:37:28 -0700 (PDT)
X-Received: by 2002:a17:907:3f9e:b0:96a:2b4:eb69 with SMTP id
 hr30-20020a1709073f9e00b0096a02b4eb69mr3422885ejc.31.1684352248662; Wed, 17
 May 2023 12:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163050.127d5123@rorschach.local.home> <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
 <20230515192407.GA85@W11-BEAU-MD.localdomain> <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
 <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
 <CAHk-=wj1hh=ZUriY9pVFvD1MjqbRuzHc4yz=S2PCW7u3W0-_BQ@mail.gmail.com>
 <20230516222919.79bba667@rorschach.local.home> <CAHk-=wh_GEr4ehJKwMM3UA0-7CfNpVH7v_T-=1u+gq9VZD70mw@mail.gmail.com>
 <20230517172243.GA152@W11-BEAU-MD.localdomain> <CAHk-=whzzuNEW8UcV2_8OyuKcXPrk7-j_8GzOoroxz9JiZiD3w@mail.gmail.com>
 <20230517190750.GA366@W11-BEAU-MD.localdomain> <CAHk-=whTBvXJuoi_kACo3qi5WZUmRrhyA-_=rRFsycTytmB6qw@mail.gmail.com>
 <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
In-Reply-To: <CAHk-=wi4w9bPKFFGwLULjJf9hnkL941+c4HbeEVKNzqH04wqDA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 12:37:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
Message-ID: <CAHk-=wiiBfT4zNS29jA0XEsy8EmbqTH1hAPdRJCDAJMD8Gxt5A@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>, dthaler@microsoft.com,
        brauner@kernel.org, hch@infradead.org
Content-Type: multipart/mixed; boundary="000000000000759fcb05fbe8d165"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

--000000000000759fcb05fbe8d165
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 12:36=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. this is the patch that I think should go on top of it to fix the
> misleading "safe" and the incorrect RCU walk.

Let's actually attach the patch too. Duh.

               Linus

--000000000000759fcb05fbe8d165
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lhs3trhk0>
X-Attachment-Id: f_lhs3trhk0

IGtlcm5lbC90cmFjZS90cmFjZV9ldmVudHNfdXNlci5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJu
ZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYyBiL2tlcm5lbC90cmFjZS90cmFjZV9ldmVudHNf
dXNlci5jCmluZGV4IGIyYWVjYmZiYmQyNC4uMDU0ZTI4Y2M1YWQ0IDEwMDY0NAotLS0gYS9rZXJu
ZWwvdHJhY2UvdHJhY2VfZXZlbnRzX3VzZXIuYworKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZl
bnRzX3VzZXIuYwpAQCAtNDM5LDcgKzQzOSw3IEBAIHN0YXRpYyBib29sIHVzZXJfZXZlbnRfZW5h
Ymxlcl9leGlzdHMoc3RydWN0IHVzZXJfZXZlbnRfbW0gKm1tLAogCXN0cnVjdCB1c2VyX2V2ZW50
X2VuYWJsZXIgKmVuYWJsZXI7CiAJc3RydWN0IHVzZXJfZXZlbnRfZW5hYmxlciAqbmV4dDsKIAot
CWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbmFibGVyLCBuZXh0LCAmbW0tPmVuYWJsZXJzLCBs
aW5rKSB7CisJbGlzdF9mb3JfZWFjaF9lbnRyeShlbmFibGVyLCBuZXh0LCAmbW0tPmVuYWJsZXJz
LCBsaW5rKSB7CiAJCWlmIChlbmFibGVyLT5hZGRyID09IHVhZGRyICYmCiAJCSAgICAoZW5hYmxl
ci0+dmFsdWVzICYgRU5BQkxFX1ZBTF9CSVRfTUFTSykgPT0gYml0KQogCQkJcmV0dXJuIHRydWU7
CkBAIC00NTUsMTkgKzQ1NSwxOSBAQCBzdGF0aWMgdm9pZCB1c2VyX2V2ZW50X2VuYWJsZXJfdXBk
YXRlKHN0cnVjdCB1c2VyX2V2ZW50ICp1c2VyKQogCXN0cnVjdCB1c2VyX2V2ZW50X21tICpuZXh0
OwogCWludCBhdHRlbXB0OwogCisJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZXZlbnRfbXV0ZXgpOwor
CiAJd2hpbGUgKG1tKSB7CiAJCW5leHQgPSBtbS0+bmV4dDsKIAkJbW1hcF9yZWFkX2xvY2sobW0t
Pm1tKTsKLQkJcmN1X3JlYWRfbG9jaygpOwogCi0JCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGVu
YWJsZXIsICZtbS0+ZW5hYmxlcnMsIGxpbmspIHsKKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShlbmFi
bGVyLCAmbW0tPmVuYWJsZXJzLCBsaW5rKSB7CiAJCQlpZiAoZW5hYmxlci0+ZXZlbnQgPT0gdXNl
cikgewogCQkJCWF0dGVtcHQgPSAwOwogCQkJCXVzZXJfZXZlbnRfZW5hYmxlcl93cml0ZShtbSwg
ZW5hYmxlciwgdHJ1ZSwgJmF0dGVtcHQpOwogCQkJfQogCQl9CiAKLQkJcmN1X3JlYWRfdW5sb2Nr
KCk7CiAJCW1tYXBfcmVhZF91bmxvY2sobW0tPm1tKTsKIAkJdXNlcl9ldmVudF9tbV9wdXQobW0p
OwogCQltbSA9IG5leHQ7Cg==
--000000000000759fcb05fbe8d165--
