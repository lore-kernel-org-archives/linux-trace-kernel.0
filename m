Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6EFDDC8
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Oct 2023 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UItuVzNY"
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C194B9;
	Sat,  7 Oct 2023 08:39:10 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dd1db54d42so2051001fac.3;
        Sat, 07 Oct 2023 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696693147; x=1697297947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lJN7RuCz9ZjltjJkr63VcR1vl5+W7ycDgx1Cg/Hr84=;
        b=UItuVzNY4P+xHEgHPjwS3BSIJ7rj9Ismu4AFOMqAzNp7iC3NOUcVgcVlty0Qkvys/a
         lvXSG+eE1H3mkIqf39LtJugAJ5pgc8I+Bs7VfSK+RgIm9WpENTZa9azlmAoc+Sy2yx0W
         jjKR8XV5akamTkAb3wmTedIxUcrmgWpa843xCVSKgDG6EVY38cyi4MbpAN1eLpGGRxLi
         tDnz+nDL37DQRAFX1nOGXCwrp9npvhOEeQ7rkAsryPEa6ToPkGSf791ZQqNPkry4PiBw
         SNEuv0nyxSn1teeEbwgu2WpLpHhct1CkVwISFGvgYwWikWW0kpQNQsynAhZc2FSdgqO0
         2RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696693147; x=1697297947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lJN7RuCz9ZjltjJkr63VcR1vl5+W7ycDgx1Cg/Hr84=;
        b=peEPSwhOiMM9oDR5hBnEL1AP1KmvAcLeoS1qpN83liqvIfmvQkEdDzkgldg3LwfM0z
         3elLNgG4IGDN3aTvnLU843LORhfmd2V6kUvORb7RNsm9iUROEeowSMasOse05XIzUmZo
         1rzPVEhgPtH6TXvfo8f4zVpvCnvwHDV30vGphAP1OwnQi1tYU/PWdeMAGo6H+88E/z/u
         BD+4S21LJKcuoeayQvf7BEEPHpPrVs4yrB39AL1k+96hjD6kuCnkJ0bNIF6PBlAwiE33
         GMwrspvmCy9VrUGIZP1Qc77tHIWbsZFNajYx7GhVGrgiw+t9InboYXJnOLX//LPV6Baa
         frJg==
X-Gm-Message-State: AOJu0YyTXgslbHg/VsZFC7lK8lC4u9AnbTGJcTu1aWLd1mqUM1hOhI2J
	Bum/P4948c0I7IhxbAqbiq0=
X-Google-Smtp-Source: AGHT+IFCF+7ptEknYG3uxPPktuAFWsMzDhdeQdX0H5Xy/UH2i3owgjFXHpdjxFEMJ3W1E/Emi9KBcg==
X-Received: by 2002:a05:6870:d689:b0:1c8:bbd0:2fc9 with SMTP id z9-20020a056870d68900b001c8bbd02fc9mr12466971oap.49.1696693147062;
        Sat, 07 Oct 2023 08:39:07 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:52e1:f940:d30d:8b60:5b64])
        by smtp.gmail.com with ESMTPSA id j5-20020aa78d05000000b0068842ebfd10sm3300016pfe.160.2023.10.07.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 08:39:06 -0700 (PDT)
Date: Sat, 7 Oct 2023 21:09:00 +0530
From: Atul Kumar Pant <atulpant.linux@gmail.com>
To: naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
	davem@davemloft.net, mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kprobes: Fixes a typo
Message-ID: <20231007153900.GA20160@atom0118>
References: <20230817170819.77857-1-atulpant.linux@gmail.com>
 <20230923173040.GA159038@atom0118>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923173040.GA159038@atom0118>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 23, 2023 at 11:00:46PM +0530, Atul Kumar Pant wrote:
> On Thu, Aug 17, 2023 at 10:38:19PM +0530, Atul Kumar Pant wrote:
> > Fixes typo in a function name.
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  samples/kprobes/kretprobe_example.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> > index cbf16542d84e..ed79fd3d48fb 100644
> > --- a/samples/kprobes/kretprobe_example.c
> > +++ b/samples/kprobes/kretprobe_example.c
> > @@ -35,7 +35,7 @@ struct my_data {
> >  	ktime_t entry_stamp;
> >  };
> >  
> > -/* Here we use the entry_hanlder to timestamp function entry */
> > +/* Here we use the entry_handler to timestamp function entry */
> >  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> >  {
> >  	struct my_data *data;
> > -- 
> > 2.25.1
> > 
> 
> 	Hi all, can someone provide comments on this change.

			Hi all, can someone please review this change. It has been not
			reviewed for quite some time.
