Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806027E3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:27:33 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D219B
	for <linux-trace-kernel@vger.kernel.org>; Sun,  1 Oct 2023 20:27:30 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-419886c7474so250071cf.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 01 Oct 2023 20:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696217250; x=1696822050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3scGPNEBOwqptWVfFKrAiu9JumQod6q+Tv1f0Kk9vI8=;
        b=p0I0WQngiMTljmtIUk48OauD++yGbo0q4BsGs1uucpi8V2/5luig3wKUKgZCXced/h
         P2tkQk3Ut/vOBa/lHXxiFpa+ScXwTzv374fCNQGQD5R+5qeF3WjSFHw/fdzWmz/cZnX4
         CWTCjSu3dbC9yryQuEo0pHJYJtQa5QeieUJNiffCp6rp9JWOTQy8vpmfJeXLFtD3Ztv5
         IAIoPfhAFPtvRvjuY93QnmQmiAzY6LxhMj78rLx0z6cIHTMErYZ98oq6Rit+bSC1A+2R
         MWW4yYQ68q8T1YUofP5xbOoBp2Z5ie39dbnQ0wisy1cGdhsRpnueHQvVN28czXOTSjpw
         BFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696217250; x=1696822050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3scGPNEBOwqptWVfFKrAiu9JumQod6q+Tv1f0Kk9vI8=;
        b=XRxTW1i4gIMFDhlWUR80Zsz1x58OOW1mpOqfn8O3JWcq+vZPoA0VrU9Crsg1FVp1jn
         OKjDFNWHq9XtRB0+B9BG6DC9Z9wUleyezuM7CJMB5ixkVcH2x/PM1yESeNI1GgIk2P5W
         EPahmxwGbEj7Ps8K4b1oWmfxshWy8rPhJ2rCbpID2VXp1OiPsqac9qRnrlgKv0awa97p
         8hsfBKxRjy/Czo3zTvmCoEJTNPWYbeQDInCYMppd4Q0QCxSRPLSDXwrC3sQ5SRludjNW
         lVwM3pjSsrUC1E1yPiqbPSzYrHWq48e/NDaKkyBpx6cllPbQSELoYjS6EgslLLKO1Iv5
         8Pug==
X-Gm-Message-State: AOJu0Yz+OmACHt2GAkWk3JKJukKtfI015AYh7HsfsOSMj8F/xWxJ6U8K
	gCejXmhpKT6xxf9xk5UB+LaBzNNTwvIDaa9Zvq0cWg==
X-Google-Smtp-Source: AGHT+IGENNrmhb+4VzqpTVANnEdpNQzdc47Y1/jQh2hnXoAhQ9KrK2qnZ25Hg3IgVO1OgzS81imF8a9kjErZFI/73jk=
X-Received: by 2002:ac8:5746:0:b0:417:cd31:a2f6 with SMTP id
 6-20020ac85746000000b00417cd31a2f6mr235602qtx.1.1696217249641; Sun, 01 Oct
 2023 20:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926051035epcms1p312b531bba2c17bb763b6f046a45c86da@epcms1p3>
 <CAOUHufZwLET1E9dQq15LX27v+20HwWstL4XFi+qzVuz1voLW=w@mail.gmail.com>
 <20230926042250.6028-1-jaewon31.kim@samsung.com> <CGME20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c@epcms1p5>
 <20230926073333epcms1p14c9798232b395007eb20becb5dbc4b4e@epcms1p1>
 <20230926141519epcms1p5b7808c768df48647516f458529e4e3c8@epcms1p5> <CAJrd-Uu16oZncaFzycGoyryxyjEGFWJdecQoShveGV6_GGJLiQ@mail.gmail.com>
In-Reply-To: <CAJrd-Uu16oZncaFzycGoyryxyjEGFWJdecQoShveGV6_GGJLiQ@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 1 Oct 2023 21:26:53 -0600
Message-ID: <CAOUHufaqROR00_u6enJxhvGuPLTLMW_t4MSMqvDuyGpTECU3Mg@mail.gmail.com>
Subject: Re: [PATCH v4] vmscan: add trace events for lru_gen
To: Jaewon Kim <jaewon31.kim@gmail.com>
Cc: jaewon31.kim@samsung.com, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"tjmercier@google.com" <tjmercier@google.com>, "kaleshsingh@google.com" <kaleshsingh@google.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "sj@kernel.org" <sj@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 1, 2023 at 5:41=E2=80=AFPM Jaewon Kim <jaewon31.kim@gmail.com> =
wrote:
>
> Hello Yu Zhao
>
> Could you give me your comment? I am waiting for your opinion on the
> reuse method. I'm planning to resend it as a complete patch with it.
> Thank you.

Acked-by: Yu Zhao <yuzhao@google.com>
