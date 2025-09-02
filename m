Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6202147E6;
	Tue,  2 Sep 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836578; cv=none; b=igJWtvolAkwgRtZ8TZyn4oEH7dvn/YsZrHSnZKDUoLGMUXPtnbDaWy/IOSPRu/DqvdDMSPUH59S3I3T4mfquh/KNy4rUME8AiknIOVLptd+5CNcKVm3VZyHIen5s8cdq1miMl8irKO1aqcsnx5jWF3Qrxaqqh1EQaoa+u6bgaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836578; c=relaxed/simple;
	bh=0L92IAUziNvNfAmcUTkrdk+mI92e4YaDMRgPtCfWEuQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXBLPvzzQSluXBaBrexJ2bYjvwwbOlo/nSTVuSpmGCRXkx+WMAa0XrPds4lDtb5cS936xk9+lWhAaHLbvAyLUqE7xkQQx1SRJu4LrPieoGGRoyyd+Oj0lb2r/U3r66232aV0EZ6UMVh68TceZ4DaFvmiBRx+qwoF34JCkZzAJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxYrAxGI; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxYrAxGI"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-71a2d730d03so18177226d6.3;
        Tue, 02 Sep 2025 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756836575; x=1757441375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6p2iaxf1xKy8cucNERCImCIG2yh14K1c4hbzVAT+H/w=;
        b=TxYrAxGIXChcqdPoyt10T3TEVhtIFD+O3uTrUmHo8In++Rs1OSAlAKR9rGesHglj55
         eARuVBD+AtIY8pdTHB20I3mq2+1LFD6Uh13Wd8gDavy0coL3pH5vYmo6Ld110Td4wc49
         /Q/itbyu7Qtrz5llrd01pxWgP4tTfi4FRUiYXBZ35YMbd+i0RPF/uQPk9eZbbX1QJ5b1
         jjOEb1vBfCPQWzyY0QKy/LIcSLalUip1W5+aWYy+q3HBMW+Ubhm8hPUgfW7kISOfB9A/
         Fed98vC2BM+NNe5LBxmLvn+lkPhxSem6dQF+Tmf+vEorbhRguEGsZwKgtX2v3MEjSm0o
         s8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756836575; x=1757441375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p2iaxf1xKy8cucNERCImCIG2yh14K1c4hbzVAT+H/w=;
        b=S86oApvIkyUlzgOMxUQWWUcyGj2b46QzAxS1ZOHc3hpmJc0xDccaF32WYYRJLgeaRm
         UZWBJDkdwt7P+fofqICpio3FYV1T2fUBlcshHiGUZhscKNbLFuu8nv59xXgHIPbUfvSl
         dqYqVNkJ+aqp1lSzBEdF/M0LsnYsjv7XQxB7AG18Mvy33sBokPE7T7Kp0MsI5A9t14R9
         iygAMWlJwkEl6WB59SwhMxH5wTr2hmySbZ4ef642FRvmIA+kB+ts9avKBKXy3ICvhPwE
         baRyOukRtJQTUdET+P94vmE9NqecVCDZKzN1F543mUKUW/lVrduKf0X+Wq/1ehUwbLNw
         RQTw==
X-Forwarded-Encrypted: i=1; AJvYcCUf1yrNC7vRVEKcyrNvrpNJTb/l+gtHT0DrBQTlBFplyol3cfLr9nHl5gk0CVhpZSfsyRb1JFCevsgAW/i6VC+edxdi@vger.kernel.org, AJvYcCV8Wt3tO1QRm421rz/tE1bmEXQwV6QolVA80goGR/Ol5FsXNiCvjirq8H5n7wRgVi184vomCQQY72hsE8xl@vger.kernel.org, AJvYcCXRihf1Fg02gDG6sOg+/aQAc58chfboGV8tBng/NvgUXtTEWvTCXiMMGjFmKFEw7mse8cbKFRd37nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOKIN0PgjPaO6MbkU6l61G1iOvG8QCYvXTZwcmy7rZsvb4Oygt
	HtDoU37DYw8RwVbWBakTJVdTnHIC5F7IEdyOkTBYI3tPM7CsTXwoWuhZ
X-Gm-Gg: ASbGnctAgAj09UnZJlMCR7HxrFbX2nxvYqO0W6DMyI/F4myJ01QkKB8SJJfLAgo3Rv7
	mZc0WEyX9YKX0DiQqt1T1ptckPv2NzEzXAEgMlxTapVg5feeY+KuXV3qyEtUtPF5dxFfaS8UvOk
	eHO0fVBIw2w8CctZljfVj7M1EfI3Db/xxHQU9ge4BLLHWvMnVVls9qkbtPrJZHlVMMpRBBOiZ+q
	tOT5hlcLP5IAwcUeBt7MxHWoyQoqYRhaHH5Rtgk/i/NlAg9wuAJIxLW9ANScWZLuk3UtkvrUBg6
	5pY+o/Nceru1virh1sJCD8KHfuYrRrLTSpQmG3DYFd5P7rjjEeoGjppo65t5P/Hxf4JHSSjZ0xZ
	BkAXqt3vIeFdeRfeXx155I2h9xZp2Y6qzcDY=
X-Google-Smtp-Source: AGHT+IF8z6iDNNlWO8O3jO1uwuPXCaRCgFAqH5i81eo36J0SYm4UWdKSZslZI3tIZpmXBYQgJAIklg==
X-Received: by 2002:a05:6214:1256:b0:70d:ca4f:5121 with SMTP id 6a1803df08f44-70fac78fa83mr182734256d6.25.1756836575247;
        Tue, 02 Sep 2025 11:09:35 -0700 (PDT)
Received: from ideapad ([130.64.64.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b475d63asm15668396d6.48.2025.09.02.11.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:09:34 -0700 (PDT)
Date: Tue, 2 Sep 2025 14:09:33 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Crystal Wood <crwood@redhat.com>, rostedt@goodmis.org, corbet@lwn.net, 
	tglozar@redhat.com, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rtla: fix -C/--cgroup interface
Message-ID: <jbf4si2tfwlquzna4sxbemr53ecwo3xwuroi5als5vlk4vla72@trp4p7jxw2ue>
References: <cover.1755018581.git.ipravdin.official@gmail.com>
 <9394c039d5c957bd8417669148391e20fa1276ee.1755018581.git.ipravdin.official@gmail.com>
 <3b9bf6e435b2eb85b44557d474a003ec6d2c0c1c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b9bf6e435b2eb85b44557d474a003ec6d2c0c1c.camel@redhat.com>

On Fri, Aug 29, 2025 at 02:12:28PM -0500, Crystal Wood wrote:
> On Tue, 2025-08-12 at 13:21 -0400, Ivan Pravdin wrote:
> > Currently, user can only specify cgroup to the tracer's thread the
> > following ways:
> > 
> >     `-C[cgroup]`
> >     `-C[=cgroup]`
> >     `--cgroup[=cgroup]`
> > 
> > If user tries to specify cgroup as `-C [cgroup]` or `--cgroup [cgroup]`,
> > the parser silently fails and rtla's cgroup is used for the tracer
> > threads.
> > 
> > To make interface more user-friendly, allow user to specify cgroup in
> > the aforementioned way, i.e. `-C [cgroup]` and `--cgroup [cgroup]`
> > 
> > Change documentation to reflect this user interface change.
> 
> I know these are the semantics that --trace implements, but they're
> rather atypical... especially -C=group.

The new semantics allow for -C [group] which is the same as -t
[filename] that has been fixed for -t/--trace.

> 
> > @@ -559,12 +559,17 @@ static struct osnoise_params
> >  			break;
> >  		case 'C':
> >  			params->cgroup = 1;
> > -			if (!optarg) {
> > -				/* will inherit this cgroup */
> > +			if (optarg) {
> > +				if (optarg[0] == '=') {
> > +					/* skip the = */
> > +					params->cgroup_name = &optarg[1];
> > +				} else {
> > +					params->cgroup_name = optarg;
> > +				}
> > +			} else if (optind < argc && argv[optind][0] != '-') {
> > +				params->cgroup_name = argv[optind];
> > +			} else {
> >  				params->cgroup_name = NULL;
> > -			} else if (*optarg == '=') {
> > -				/* skip the = */
> > -				params->cgroup_name = ++optarg;
> 
> If we're going to be consistently using these semantics, we should move
> this logic into a utility function rather than open-coding it
> everywhere.

Sure, I will move it into a utility function in the next version.
 
> Also, theoretically, shouldn't we be advancing optind for the case where
> that's consumed?  Not that it matters much if we don't have positional
> arguments once the options begin, and if we did, then allowing
> "--arg optional-thing" would be ambiguous...

It does seem that we should advance optind when optional argument is
provided. Good catch. I will fix it in the next version.

> -Crystal
> 

	Ivan Pravdin
